return {
	{
		"nvim-neorg/neorg",
		build = ":Neorg sync-parsers",
		ft = "norg",
		cmd = "Neorg",
		dependencies = {
			"nvim-lua/plenary.nvim",
			{
				"nvim-treesitter/nvim-treesitter",
				build = ":TSUpdate",
				opts = {
					auto_install = true,
					highlight = {
						enable = true,
						additional_vim_regex_highlighting = false,
					},
				},
				config = function(_, opts)
					require("nvim-treesitter.configs").setup(opts)
				end,
			},
			-- Interim LSP for Neorg
			{
				"benlubas/neorg-interim-ls",
				lazy = true,
			},
		},
		opts = {
			load = {
				["core.defaults"] = {},
				["core.concealer"] = {}, -- icons and folding
				["core.dirman"] = {
					config = {
						workspaces = {
							notes = "~/notes",
							journal = "~/notes/journal",
						},
						default_workspace = "notes",
					},
				},
				["core.completion"] = {
					config = {
						engine = {
							module_name = "external.lsp-completion", -- Use LSP for Neorg completion
						},
					},
				},
				["external.interim-ls"] = {
					config = {
						completion_provider = {
							enable = true,
							documentation = true,
							categories = false, -- requires benlubas/neorg-query
							people = {
								enable = false,
								path = "people",
							},
						},
					},
				},
				["core.qol.todo_items"] = {},
				["core.todo-introspector"] = {},
				["core.journal"] = {
					config = {
						strategy = "flat",
					},
				},
				["core.keybinds"] = {
					config = {
						default_keybinds = true,
						neorg_leader = "<Leader>n",
					},
				},
				["core.export"] = {},
				["core.export.markdown"] = {},
				["core.ui.calendar"] = {},
				["core.esupports.metagen"] = {},
				["core.looking-glass"] = {},
				["core.clipboard.code-blocks"] = {},
				["core.qol.toc"] = {},
				["core.pivot"] = {},
				["core.promo"] = {},
			},
		},
		config = function(_, opts)
			require("neorg").setup(opts)

			-- Set up LSP keymaps for Neorg Interim LS
			vim.api.nvim_create_autocmd("LspAttach", {
				callback = function(args)
					local bufnr = args.buf
					local client = vim.lsp.get_client_by_id(args.data.client_id)
					if not client then
						return
					end

					if client.server_capabilities.completionProvider then
						vim.bo[bufnr].omnifunc = "v:lua.vim.lsp.omnifunc"
					end

					local map = vim.keymap.set
					local opts = { noremap = true, silent = true, buffer = bufnr }

					map("n", "<leader>rn", vim.lsp.buf.rename, opts)
					map("n", "gr", vim.lsp.buf.references, opts)
				end,
			})
		end,
	},
}
