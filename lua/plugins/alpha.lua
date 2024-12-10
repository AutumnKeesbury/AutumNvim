return {
  "goolord/alpha-nvim",
  event = "VimEnter",
  enabled = true,
  init = false,
  opts = function()
    local dashboard = require("alpha.themes.dashboard")
    -- Define and set highlight groups for each logo line
    vim.api.nvim_set_hl(0, "NeovimDashboardLogo1", { fg = "#9d0208" }) -- Red
    vim.api.nvim_set_hl(0, "NeovimDashboardLogo2", { fg = "#d00000" }) -- Red-Orange
    vim.api.nvim_set_hl(0, "NeovimDashboardLogo3", { fg = "#dc2f02" }) -- Orange-red
    vim.api.nvim_set_hl(0, "NeovimDashboardLogo4", { fg = "#e85d04" }) -- Orange-Yellow
    vim.api.nvim_set_hl(0, "NeovimDashboardLogo5", { fg = "#f48c06" }) -- Yellow-Orange
    vim.api.nvim_set_hl(0, "NeovimDashboardLogo6", { fg = "#faa307" }) -- Yellow
    vim.api.nvim_set_hl(0, "NeovimDashboardUsername", { fg = "#ffc971" }) -- Faded Red
    dashboard.section.header.type = "group"
    dashboard.section.header.val = {
      { type = "text", val = "█████╗ ██╗    ██╗████████╗██╗   ██╗███╗   ███╗███╗   ██╗ ███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗", opts = { hl = "NeovimDashboardLogo1", shrink_margin = false, position = "center" }, },
      { type = "text", val = "██╔══██╗██║   ██║╚══██╔══╝██║   ██║████╗ ████║████╗  ██║ ██╔════╝██╔═══██╗██║   ██║██║████╗ ████║", opts = { hl = "NeovimDashboardLogo2", shrink_margin = false, position = "center" }, },
      { type = "text", val = "███████║██║   ██║   ██║   ██║   ██║██╔████╔██║██╔██╗ ██║ █████╗  ██║   ██║██║   ██║██║██╔████╔██║", opts = { hl = "NeovimDashboardLogo3", shrink_margin = false, position = "center" }, },
      { type = "text", val = "██╔══██║██║   ██║   ██║   ██║   ██║██║╚██╔╝██║██║╚██╗██║ ██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║", opts = { hl = "NeovimDashboardLogo4", shrink_margin = false, position = "center" }, },
      { type = "text", val = "██║  ██║╚██████╔╝   ██║   ╚██████╔╝██║ ╚═╝ ██║██║ ╚████║ ███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║", opts = { hl = "NeovimDashboardLogo5", shrink_margin = false, position = "center" }, },
      { type = "text", val = "╚═╝  ╚═╝ ╚═════╝    ╚═╝    ╚═════╝ ╚═╝     ╚═╝╚═╝  ╚═══╝ ╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝", opts = { hl = "NeovimDashboardLogo6", shrink_margin = false, position = "center" }, },
      { type = "padding", val = 1, },
      { type = "text", val = "Autumn's NeoVIM (◕‿◕✿)", opts = { hl = "NeovimDashboardUsername", shrink_margin = false, position = "center" }, },
    }
    -- stylua: ignore
    vim.api.nvim_set_hl(0, "AlphaHeader", { fg = "#ee964b" }) -- Orange-Tan
    vim.api.nvim_set_hl(0, "AlphaShortcut", { fg = "ce4257" }) -- Light Magenta
    vim.api.nvim_set_hl(0, "AlphaFooter", { fg = "#edd691" })

    dashboard.section.header.opts.hl = "AlphaHeader"
    dashboard.section.footer.opts.hl = "AlphaFooter"
    dashboard.opts.layout[1].val = 3
    return dashboard
  end,
  config = function(_, dashboard)
    -- close Lazy and re-open when the dashboard is ready
    if vim.o.filetype == "lazy" then
      vim.cmd.close()
      vim.api.nvim_create_autocmd("User", {
        once = true,
        pattern = "AlphaReady",
        callback = function()
          require("lazy").show()
        end,
      })
    end

    require("alpha").setup(dashboard.opts)

    vim.api.nvim_create_autocmd("User", {
      once = true,
      pattern = "LazyVimStarted",
      callback = function()
        local stats = require("lazy").stats()
        local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
        dashboard.section.footer.val = "⚡ Neovim loaded "
          .. stats.loaded
          .. "/"
          .. stats.count
          .. " plugins in "
          .. ms
          .. "ms"
        pcall(vim.cmd.AlphaRedraw)
      end,
    })
  end,
}
