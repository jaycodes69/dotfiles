return {
	"rebelot/kanagawa.nvim",
	lazy = false,
	priority = 1000,
	config = function()
		require("kanagawa").setup({
			compile = true, -- Fast startup
			undercurl = true,
			commentStyle = { italic = true },
			functionStyle = {},
			keywordStyle = { italic = true },
			statementStyle = { bold = true },
			typeStyle = {},
			transparent = true, -- No background (good for transparent terminals)
			dimInactive = false,
			terminalColors = true,
			theme = "wave",
			background = {
				dark = "wave",
				light = "lotus",
			},
			colors = {
				theme = {
					all = {
						ui = {
							bg_gutter = "none", -- No background in gutter
						},
					},
				},
			},
			overrides = function(colors)
				local theme = colors.theme
				local c = require("kanagawa.lib.color")
				local blend = function(fg, bg, alpha)
					return c(fg):blend(bg, alpha):to_hex()
				end

				local makeDiagnosticColor = function(color)
					return {
						fg = color,
						bg = blend(color, theme.ui.bg, 0.95),
					}
				end

				return {
					-- Transparent floats
					NormalFloat = { bg = "none" },
					FloatBorder = { bg = "none" },
					FloatTitle = { bg = "none" },

					-- Completion menu
					Pmenu = { fg = theme.ui.shade0, bg = theme.ui.bg_p1 },
					PmenuSel = { fg = "NONE", bg = theme.ui.bg_p2 },
					PmenuSbar = { bg = theme.ui.bg_m1 },
					PmenuThumb = { bg = theme.ui.bg_p2 },

					-- Telescope
					TelescopeTitle = { fg = theme.ui.special, bold = true },
					TelescopePromptNormal = { bg = theme.ui.bg_p1 },
					TelescopePromptBorder = { fg = theme.ui.bg_p1, bg = theme.ui.bg_p1 },
					TelescopeResultsNormal = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m1 },
					TelescopeResultsBorder = { fg = theme.ui.bg_m1, bg = theme.ui.bg_m1 },
					TelescopePreviewNormal = { bg = theme.ui.bg_dim },
					TelescopePreviewBorder = { bg = theme.ui.bg_dim, fg = theme.ui.bg_dim },

					-- Diagnostics
					DiagnosticVirtualTextHint = makeDiagnosticColor(theme.diag.hint),
					DiagnosticVirtualTextInfo = makeDiagnosticColor(theme.diag.info),
					DiagnosticVirtualTextWarn = makeDiagnosticColor(theme.diag.warning),
					DiagnosticVirtualTextError = makeDiagnosticColor(theme.diag.error),
				}
			end,
		})

		vim.api.nvim_set_hl(0, "RenderMarkdownH1", { fg = "#C8D3F5", bold = true })
		vim.api.nvim_set_hl(0, "RenderMarkdownCode", { bg = "#2a2a37" }) -- subtle code bg
		vim.api.nvim_set_hl(0, "RenderMarkdownQuote", { fg = "#7E9CD8", italic = true })
		-- Load colorscheme
		vim.cmd.colorscheme("kanagawa")
	end,
}
