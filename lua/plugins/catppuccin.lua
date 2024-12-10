return {
    {
      "catppuccin/nvim",
      name = "catppuccin",
      opts = {
        dim_inactive = { enabled = true, percentage = 0.25 },
        highlight_overrides = {
          mocha = function(c)
            return {
              Normal = { bg = c.mantle },
              Comment = { fg = "#ffe6a7" },
              ["@tag.attribute"] = { style = {} },
            }
          end,
        },
      },
    },
  }