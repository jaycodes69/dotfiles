return {
  "stevearc/oil.nvim",
  lazy = false,
  opts = {
    default_file_explorer = true,
    columns = {
      "icon", -- Show file icons if devicons is installed
    },
    view_options = {
      show_hidden = true,
    },
    float = {
      padding = 2,
      max_width = 60,
      max_height = 20,
      border = "rounded",
    },
    keymaps = {
      ["<C-h>"] = false, -- Unbind default
      ["<C-l>"] = false,
      ["<C-v>"] = "actions.select_vsplit",
      ["<C-x>"] = "actions.select_split",
      ["<C-t>"] = "actions.select_tab",
      ["<Esc><Esc>"] = "actions.close",
    },
  },
  dependencies = { "nvim-tree/nvim-web-devicons" },
}
