return {
	"hrsh7th/nvim-cmp",
	event = "InsertEnter",
	dependencies = {
		-- Sources
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
		"hrsh7th/cmp-emoji",
		"hrsh7th/cmp-cmdline",
		"saadparwaiz1/cmp_luasnip",
		-- Snippets
		{
			"L3MON4D3/LuaSnip",
			build = "make install_jsregexp",
			dependencies = {
				{
					"rafamadriz/friendly-snippets",
					config = function()
						require("luasnip.loaders.from_vscode").lazy_load()

						require("luasnip.loaders.from_lua").lazy_load({ paths = "~/.config/nvim/snippets" })
					end,
				},
			},
		},
	},
	config = function()
		local cmp = require("cmp")
		local luasnip = require("luasnip")

		luasnip.config.set_config({ history = true, updateevents = "TextChanged,TextChangedI" })

		cmp.setup({
			snippet = {
				expand = function(args)
					luasnip.lsp_expand(args.body)
				end,
			},

			mapping = cmp.mapping.preset.insert({
				["<C-Space>"] = cmp.mapping.complete(),
				["<CR>"] = cmp.mapping.confirm({ select = true }),
				["<Tab>"] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.select_next_item()
					elseif luasnip.expand_or_jumpable() then
						luasnip.expand_or_jump()
					else
						fallback()
					end
				end, { "i", "s" }),

				["<S-Tab>"] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.select_prev_item()
					elseif luasnip.jumpable(-1) then
						luasnip.jump(-1)
					else
						fallback()
					end
				end, { "i", "s" }),
			}),

			sources = cmp.config.sources({
				{ name = "nvim_lsp" },
				{ name = "luasnip" },
				{ name = "path" },
				{ name = "emoji" },
				{ name = "buffer" },
				{ name = "neorg" },
			}),

			formatting = {
				format = function(entry, vim_item)
					local icons = {
						Text = "󰉿",
						Method = "󰆧",
						Function = "󰊕",
						Constructor = "",
						Field = "󰜢",
						Variable = "󰀫",
						Class = "󰠱",
						Interface = "",
						Module = "󰏗",
						Property = "󰜢",
						Unit = "󰑭",
						Value = "󰎠",
						Enum = "",
						Keyword = "󰌋",
						Snippet = "",
						Color = "󰏘",
						File = "󰈙",
						Reference = "󰈇",
						Folder = "󰉋",
						EnumMember = "",
						Constant = "󰏿",
						Struct = "󰙅",
						Event = "",
						Operator = "󰆕",
						TypeParameter = "",
					}
					vim_item.kind = string.format("%s %s", icons[vim_item.kind] or "", vim_item.kind)
					vim_item.menu = ({
						nvim_lsp = "[LSP]",
						luasnip = "[Snip]",
						buffer = "[Buf]",
						path = "[Path]",
						emoji = "[Emoji]",
					})[entry.source.name]
					return vim_item
				end,
			},

			window = {
				documentation = cmp.config.window.bordered(),
				completion = cmp.config.window.bordered(),
			},

			experimental = {
				ghost_text = { hl_group = "Comment" },
			},
		})

		-- Command-line completion
		cmp.setup.cmdline(";", {
			mapping = cmp.mapping.preset.cmdline(),
			sources = cmp.config.sources({
				{ name = "path" },
				{ name = "cmdline" },
			}),
		})

		cmp.setup.cmdline("/", {
			mapping = cmp.mapping.preset.cmdline(),
			sources = { { name = "buffer" } },
		})

		-- ✨ Highlighting for Kanagawa (or similar palette)
		local hl = vim.api.nvim_set_hl
		hl(0, "CmpItemAbbr", { fg = "#C8C093" })
		hl(0, "CmpItemAbbrMatch", { fg = "#957FB8", bold = true })
		hl(0, "CmpItemAbbrMatchFuzzy", { fg = "#957FB8", italic = true })
		hl(0, "CmpItemMenu", { fg = "#7E9CD8" })
		hl(0, "CmpItemKindFunction", { fg = "#7FB4CA" })
		hl(0, "CmpItemKindVariable", { fg = "#98BB6C" })
		hl(0, "CmpItemKindClass", { fg = "#E6C384" })
		hl(0, "CmpItemKindKeyword", { fg = "#957FB8" })
		hl(0, "CmpItemKindText", { fg = "#FF9E3B" })
	end,
}
