vim.cmd([[
set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath=&runtimepath
source ~/.vimrc
]])

vim.lsp.enable('pyright')

require "user.plugins"
require "user.toggleterm"

vim.g.copilot_workspace_folders = {
	"~/Desktop/puppetlegion/puppetlegion/",
	"~/Desktop/nil_wizard/modules/stealth_roi_extraction/",
	"~/Desktop/brain_aneurysm_detection/challenge_repo/",
}

require "user.cmp"

----------------------------------------------------------------
-- Folders in whose *path* Copilot should be disabled
local disable_folders = {
  "journal",
  "journals",
  -- "schedule",
  -- "notes",
}

local disabled = {}
for _, d in ipairs(disable_folders) do
  disabled[d:lower()] = true
end

local function path_segments(p)
  -- normalize separators and split into components
  p = p:gsub("\\", "/")
  local segs = {}
  for seg in p:gmatch("[^/]+") do
    segs[#segs+1] = seg
  end
  return segs
end

local group = vim.api.nvim_create_augroup("CopilotToggle", { clear = true })

local function toggle_copilot()
  local name = vim.api.nvim_buf_get_name(0)
  if name == "" then return end
  if vim.bo.buftype ~= "" then return end            -- skip help/quickfix/etc.
  if vim.fn.isdirectory(name) == 1 then return end   -- skip directory buffers

  local dir = vim.fn.fnamemodify(name, ":h")
  local disable = false
  for _, seg in ipairs(path_segments(dir)) do
    if disabled[seg:lower()] then
      disable = true
      break
    end
  end

  -- Try to toggle via :Copilot if available; otherwise set buffer var (copilot.lua respects this)
  if disable then
    pcall(vim.cmd, "Copilot disable")
    vim.b.copilot_enabled = false
  else
    pcall(vim.cmd, "silent! Copilot enable")
    vim.b.copilot_enabled = true
  end
end

vim.api.nvim_create_autocmd({ "BufReadPost", "BufNewFile", "BufWinEnter" }, {
  group = group,
  callback = toggle_copilot,
})
----------------------------------------------------------------

vim.keymap.set('n', '<leader>d', function()
  vim.cmd('update')
  local root = project_root()
  vim.fn.jobstart(
    { 'python3.13', 'manage.py', 'shell', '-c', 'import data_explorer.viz_dev as v; v.deploy()' },
    {
      cwd = root,
      stdout_buffered = true,
      on_stdout = function(_, data)
        if data then vim.notify(table.concat(data, '\n'), vim.log.levels.INFO, { title = 'deploy' }) end
      end,
      on_stderr = function(_, data)
        if data then vim.notify(table.concat(data, '\n'), vim.log.levels.ERROR, { title = 'deploy' }) end
      end,
    }
  )
end, { desc = 'Deploy viz_dev (async)' })
