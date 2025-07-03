return {
	"neovim/nvim-lspconfig",
	dependencies = {
		-- Plugin manager for LSP servers
		{ "williamboman/mason.nvim", opts = {} },
		"williamboman/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",

		-- Completion engine and dependencies
		"hrsh7th/nvim-cmp",
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
		"hrsh7th/cmp-emoji",
		"hrsh7th/cmp-cmdline",
		"saadparwaiz1/cmp_luasnip",
		{
			"L3MON4D3/LuaSnip",
			build = "make install_jsregexp",
			dependencies = {
				{
					"rafamadriz/friendly-snippets",
					config = function()
						require("luasnip.loaders.from_vscode").lazy_load()
					end,
				},
			},
		},
	},

	config = function()
		local lspconfig = require("lspconfig")
		local cmp = require("cmp")
		local luasnip = require("luasnip")

		-- Enable better LSP completion support
		local capabilities = require("cmp_nvim_lsp").default_capabilities()

		-- LSP servers with specific config
		local servers = {
			lua_ls = {
				settings = {
					Lua = {
						diagnostics = {
							globals = { "vim" },
							disable = { "missing-fields" },
						},
						workspace = {
							checkThirdParty = false,
							library = {
								vim.env.VIMRUNTIME,
							},
						},
						completion = { callSnippet = "Replace" },
						telemetry = { enable = false },
					},
				},
			},
			clangd = {
				cmd = {
					"clangd",
					"--background-index",
					"--clang-tidy",
					"--header-insertion=iwyu",
					"--completion-style=detailed",
					"--function-arg-placeholders",
					"--fallback-style=llvm",
				},
				init_options = {
					usePlaceholders = true,
					completeUnimported = true,
					clangdFileStatus = true,
				},
			},
			markdown_oxide = {}, -- Markdown LSP
			hyprls = {},
		}

		-- Install LSP servers and formatters automatically
		local tools = vim.tbl_keys(servers)
		vim.list_extend(tools, { "stylua", "clang-format", "shfmt", "prettier" })

		require("mason-tool-installer").setup({
			ensure_installed = tools,
			run_on_start = true,
			automatic_installation = true,
		})

		require("mason-lspconfig").setup({
			ensure_installed = vim.tbl_keys(servers),
			automatic_enable = true,
			automatic_installation = true,
			handlers = {
				function(server)
					lspconfig[server].setup(vim.tbl_deep_extend("force", {
						capabilities = capabilities,
					}, servers[server] or {}))
				end,
			},
		})

		-- Set up LSP keymaps and features
		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("LSPAttach", { clear = true }),
			callback = function(event)
				local client = vim.lsp.get_client_by_id(event.data.client_id)
				local buf = event.buf
				if not client then
					return
				end

				local map = function(keys, func, desc)
					vim.keymap.set("n", keys, func, { buffer = buf, desc = "LSP: " .. desc })
				end

				-- Basic LSP navigation
				map("gd", vim.lsp.buf.definition, "Go to Definition")
				map("gr", vim.lsp.buf.references, "Find References")
				map("K", vim.lsp.buf.hover, "Hover Info")
				map("<leader>lrn", vim.lsp.buf.rename, "Rename")
				map("<leader>lca", vim.lsp.buf.code_action, "Code Action")
				map("<leader>lcf", function()
					vim.lsp.buf.format({ async = true })
				end, "Format")

				-- Document highlight
				if client.supports_method("textDocument/documentHighlight") then
					local hl = vim.api.nvim_create_augroup("LspHighlight", { clear = false })
					vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
						group = hl,
						buffer = buf,
						callback = vim.lsp.buf.document_highlight,
					})
					vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
						group = hl,
						buffer = buf,
						callback = vim.lsp.buf.clear_references,
					})
				end

				-- Inlay hints (requires Neovim >= 0.10)
				if client.supports_method("textDocument/inlayHint") and vim.lsp.inlay_hint then
					vim.lsp.inlay_hint.enable(true, { bufnr = buf })
					vim.keymap.set("n", "<leader>lth", function()
						local enabled = vim.lsp.inlay_hint.is_enabled({ bufnr = buf })
						vim.lsp.inlay_hint.enable(not enabled, { bufnr = buf })
					end, { buffer = buf, desc = "Toggle Inlay Hints" })
				end
			end,
		})

		-- Diagnostic UI
		vim.diagnostic.config({
			update_in_insert = false,
			severity_sort = true,
			float = { border = "rounded", source = "if_many" },
			underline = true,
			signs = {
				text = {
					[vim.diagnostic.severity.ERROR] = " ",
					[vim.diagnostic.severity.WARN] = " ",
					[vim.diagnostic.severity.INFO] = " ",
					[vim.diagnostic.severity.HINT] = " ",
				},
			},
			virtual_text = {
				spacing = 4,
				source = "if_many",
				severity = { min = vim.diagnostic.severity.WARN },
				prefix = "●",
			},
		})

		-- Diagnostic navigation
		vim.keymap.set("n", "]d", function()
			vim.diagnostic.jump({ count = 1, float = true })
		end, { desc = "Next Diagnostic" })
		vim.keymap.set("n", "[d", function()
			vim.diagnostic.jump({ count = -1, float = true })
		end, { desc = "Prev Diagnostic" })
		vim.keymap.set("n", "<leader>ll", vim.diagnostic.open_float, { desc = "Line Diagnostics" })
		vim.keymap.set("n", "<leader>lq", vim.diagnostic.setloclist, { desc = "Diagnostic List" })

		-- Performance
		vim.opt.updatetime = 250
		vim.opt.pumheight = 10
		vim.opt.completeopt = { "menu", "menuone", "noselect" }
	end,
}
