return {
	{
		"stevearc/conform.nvim",
		cmd = { "ConformInfo" },
		event = "BufWritePre",
		keys = {
			{
				"<leader>lf",
				function()
					require("conform").format({ async = true, lsp_fallback = true })
				end,
				mode = "n",
				desc = "[F]ormat buffer",
			},
		},
		opts = {
			notify_on_error = false,

			-- 🔁 Autoformat on save
			format_on_save = function(bufnr)
				local disabled = {
					-- Disable formatting for filetypes here if needed
					-- Example: markdown = true,
				}
				if disabled[vim.bo[bufnr].filetype] then
					return
				end
				return {
					timeout_ms = 500,
					lsp_fallback = true,
				}
			end,

			-- 📦 Formatters by filetype
			formatters_by_ft = {
				lua = { "stylua" },
				python = { "isort", "black" },
				javascript = { { "prettierd", "prettier" } },
				typescript = { { "prettierd", "prettier" } },
				json = { "jq" },
				sh = { "shfmt" },
				markdown = { "prettierd", "prettier" },
				c = { "clang_format" },
				cpp = { "clang_format" },
				java = { "clang_format" },
			},

			-- Optional: customize formatter args
			formatters = {
				clang_format = {
					prepend_args = {
						"--style=Google", -- You can change to: LLVM, Mozilla, WebKit, Chromium, etc.
					},
				},
				shfmt = {
					prepend_args = { "-i", "2", "-ci" },
				},
			},
		},
	},
}
