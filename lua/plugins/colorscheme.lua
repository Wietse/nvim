return {
  "ellisonleao/gruvbox.nvim",
  priority = 100,
  config = function()
    require("gruvbox").setup({
      terminal_colors = true,
      contrast = "hard",  -- can be "hard", "soft" or empty string
      transparent_mode = false,
      dim_inactive = false,
    })
    vim.cmd("colorscheme gruvbox")
  end,
}
