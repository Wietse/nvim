local colors = {
  dark_red_hard = "#792329",
  dark_red = "#722529",
  dark_red_soft = "#7b2c2f",
  light_red_hard = "#fc9690",
  light_red = "#fc9487",
  light_red_soft = "#f78b7f",
  dark_green_hard = "#5a633a",
  dark_green = "#62693e",
  dark_green_soft = "#686d43",
  light_green_hard = "#d3d6a5",
  light_green = "#d5d39b",
  light_green_soft = "#cecb94",
  dark_aqua_hard = "#3e4934",
  dark_aqua = "#49503b",
  dark_aqua_soft = "#525742",
  light_aqua_hard = "#e6e9c1",
  light_aqua = "#e8e5b5",
  light_aqua_soft = "#e1dbac",
}

return {
  {
    "ellisonleao/gruvbox.nvim",
    priority = 100,
    config = function()
      require("gruvbox").setup({
        terminal_colors = true,
        contrast = "hard", -- can be "hard", "soft" or empty string
        transparent_mode = false,
        dim_inactive = false,
        -- overrides = {
        --   DiffDelete = { bg = colors.light_red_hard },
        --   DiffAdd = { bg = colors.light_green_hard },
        --   DiffChange = { bg = colors.light_aqua_hard },
        --   -- DiffText = { bg = colors.yellow, fg = colors.bg0 },
        -- }
      })
      vim.cmd("colorscheme gruvbox")
    end,
  },
  { "cormacrelf/vim-colors-github" },
}
