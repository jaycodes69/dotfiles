return {
	"saghen/blink.cmp",
	version = "1.*",
	build = "cargo build --release", -- Compile the Rust fuzzy matcher
	event = "InsertEnter",

	dependencies = {
		"rafamadriz/friendly-snippets", -- Snippet collection

		-- LazyDev enables intelligent LuaLS workspace for your nvim config
		{
			"folke/lazydev.nvim",
			ft = "lua", -- Only activate for Lua files
			opts = {
				library = {
					-- Load luvit types when vim.uv is used
					{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
					-- Load lazy.nvim types when "require('lazy')" is found
					{ path = "lazy.nvim", words = { "lazy" } },
				},
			},
		},
		{ "Bilal2453/luvit-meta", lazy = true }, -- Optional for extended Lua types
	},

	opts = function()
		return {
			-- Enable only in normal buffers
			enabled = function()
				local exclude_ft = { "TelescopePrompt", "neo-tree-popup", "DressingInput" }
				local exclude_bt = { "prompt", "nofile" }
				return not vim.tbl_contains(exclude_ft, vim.bo.filetype)
					and not vim.tbl_contains(exclude_bt, vim.bo.buftype)
					and vim.b.completion ~= false
			end,

			-- Fuzzy engine optimizations
			fuzzy = {
				use_typo_resistance = true,
				use_frecency = true,
				use_proximity = true,
				max_items = 100,
				sorts = { "label", "kind", "score" },
				prebuilt_binaries = { download = true },
			},

			-- Key mappings
			keymap = {
				preset = "default",
				["<C-n>"] = { "select_next", "fallback" },
				["<C-p>"] = { "select_prev", "fallback" },
				["<Tab>"] = { "snippet_forward", "fallback" },
				["<S-Tab>"] = { "snippet_backward", "fallback" },
				["<CR>"] = { "accept", "fallback" },
			},

			-- Pretty icons and layout
			appearance = {
				nerd_font_variant = "mono",
				kind_icons = {
					Function = "󰊕",
					Variable = "󰀫",
					Class = "󰠱",
					Module = "󰏗",
					Keyword = "󰌋",
					File = "󰈚",
				},
			},

			-- Snippets support
			snippets = {
				expand = function(snip)
					vim.snippet.expand(snip)
				end,
				jump = function(dir)
					vim.snippet.jump(dir)
				end,
			},

			-- Sources: add lazydev to boost LuaLS completions
			sources = {
				default = { "lsp", "path", "snippets", "buffer" },
				per_filetype = {
					lua = { "lazydev", "lsp", "path", "snippets", "buffer" },
				},
				providers = {
					lazydev = {
						name = "LazyDev",
						module = "lazydev.integrations.blink",
						score_offset = 100, -- Make it top priority
					},
				},
			},

			-- Signature help
			signature = {
				enabled = true,
				window = {
					border = "rounded",
					winblend = 0,
				},
			},

			-- Floating doc window
			documentation = {
				auto_show = true,
				window = {
					border = "rounded",
					winblend = 0,
				},
			},

			-- Inline ghost text
			ghost_text = { enabled = true },
		}
	end,

	config = function(_, opts)
		require("blink.cmp").setup(opts)

		-- 🎨 Kanagawa-style minimal highlights
		local hl = vim.api.nvim_set_hl
		hl(0, "BlinkCmpMenuBorder", { fg = "#957FB8" })
		hl(0, "BlinkCmpMenuSelection", { bg = "#2D1B69" })
		hl(0, "BlinkCmpKindFunction", { fg = "#7FB4CA" })
		hl(0, "BlinkCmpKindVariable", { fg = "#98BB6C" })
		hl(0, "BlinkCmpKindClass", { fg = "#E6C384" })
		hl(0, "BlinkCmpKindKeyword", { fg = "#957FB8" })
		hl(0, "BlinkCmpKindText", { fg = "#FF9E3B" })
	end,
}
