return {
  settings = {
    pylsp = {
      -- configurationSources = {"flake8"},
      plugins = {
          pycodestyle = {enabled = false},
          flake8 = {enabled = false},
          pylint = {enabled = false},
          mccabe = {enabled = false},
          pyflakes = {enabled = false},
          ruff = {enabled = true},
      }
    }
  }
}
