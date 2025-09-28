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
}

require "user.cmp"

-- Disable Copilot in certain folders like journal and schedule:
local disable_folders = {
	"journal",
	-- "schedule",
	-- "notes",
}
local pat = table.concat(disable_folders, "\\|")

local group = vim.api.nvim_create_augroup("CopilotToggle", { clear = true })

local function toggle_copilot()
  local name = vim.api.nvim_buf_get_name(0)
  if name == "" then return end
  if vim.bo.buftype ~= "" then return end                 -- no help/quickfix/NERDTree/etc
  if vim.fn.isdirectory(name) == 1 then return end        -- directory buffers
  local dir = vim.fn.fnamemodify(name, ":h")
  if dir:match(pat) then
    vim.cmd("silent! Copilot disable_folders")
  else
    vim.cmd("silent! Copilot enable")
  end
end

vim.api.nvim_create_autocmd({ "BufReadPost", "BufNewFile", "BufWinEnter" }, {
  group = group,
  callback = toggle_copilot,
})

