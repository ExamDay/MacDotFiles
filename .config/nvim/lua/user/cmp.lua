local cmp = require'cmp'

cmp.setup({
snippet = {
  -- REQUIRED - you must specify a snippet engine
  expand = function(args)
	-- For `vsnip`
	-- vim.fn["vsnip#anonymous"](args.body) 
	-- For `luasnip`.-
	require('luasnip').lsp_expand(args.body) 
	-- For `snippy`.
	-- require('snippy').expand_snippet(args.body) 
	-- For `ultisnips`.
	-- vim.fn["UltiSnips#Anon"](args.body)
	-- For native neovim snippets (Neovim v0.10+)
	-- vim.snippet.expand(args.body)

	-- For `mini.snippets`:
	-- local insert = MiniSnippets.config.expand.insert or MiniSnippets.default_insert
	-- Insert at cursor
	-- insert({ body = args.body })
	-- cmp.resubscribe({ "TextChangedI", "TextChangedP" })
	-- require("cmp.config").set_onetime({ sources = {} })
  end,
},


view = {                                                        
  entries = {name = 'custom', vertical_positioning = 'above', selection_ordering = 'bottom_up'}
},

-- -- For vsnip:
-- mapping = cmp.mapping.preset.insert({
--   ['<C-b>'] = cmp.mapping.scroll_docs(-4),
--   ['<C-f>'] = cmp.mapping.scroll_docs(4),
--   ['<C-Space>'] = cmp.mapping.complete(),
--   ['<C-e>'] = cmp.mapping.abort(),
-- -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
--   ['<CR>'] = cmp.mapping.confirm({ select = true }),
-- }),

-- For luasnip:
mapping = {
	["<C-j>"] = cmp.mapping(function(fallback)
	  if cmp.visible() then
		cmp.select_next_item()
	  elseif luasnip.locally_jumpable(1) then
		luasnip.jump(1)
	  else
		fallback()
	  end
	end, { "i", "s" }),

	["<C-k>"] = cmp.mapping(function(fallback)
	  if cmp.visible() then
		cmp.select_prev_item()
	  elseif luasnip.locally_jumpable(-1) then
		luasnip.jump(-1)
	  else
		fallback()
	  end
	end, { "i", "s" }),
},

sources = cmp.config.sources({
  { name = 'nvim_lsp' },
  { name = 'path' },
  -- { name = 'vsnip' }, -- For vsnip.
  { name = 'luasnip' }, -- For luasnip.
  -- { name = 'ultisnips' }, -- For ultisnips.
  -- { name = 'snippy' }, -- For snippy.
}, {
  { name = 'buffer' },
})
})

-- To use git you need to install the plugin petertriho/cmp-git and uncomment lines below
-- Set configuration for specific filetype.
--[[ cmp.setup.filetype('gitcommit', {
sources = cmp.config.sources({
  { name = 'git' },
}, {
  { name = 'buffer' },
})
})
require("cmp_git").setup() ]]--

-- -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
-- cmp.setup.cmdline({ '/', '?' }, {
-- mapping = cmp.mapping.preset.cmdline(),
-- sources = {
--   { name = 'buffer' }
-- }
-- })

-- -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
-- cmp.setup.cmdline(':', {
-- mapping = cmp.mapping.preset.cmdline(),
-- sources = cmp.config.sources({
--   { name = 'path' }
-- }, {
--   { name = 'cmdline' }
-- }),
-- matching = { disallow_symbol_nonprefix_matching = false }
-- })

-- Set up lspconfig.
local capabilities = require('cmp_nvim_lsp').default_capabilities()
-- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
require('lspconfig')['pyright'].setup {
capabilities = capabilities
}

