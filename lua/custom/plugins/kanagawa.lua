-- Kanagawa colorscheme - dragon variant with maximum transparency
-- Background transparency enabled to match terminal's kanagawa-dragon theme
return {
  'rebelot/kanagawa.nvim',
  priority = 1000, -- Load before other plugins to ensure theme applies first
  opts = {
    transparent = true, -- Enable transparent background
    theme = 'dragon', -- Explicitly set dragon theme
    background = {
      dark = 'dragon',
    },
    colors = {
      theme = {
        all = {
          ui = {
            bg_gutter = 'none', -- Make line numbers background transparent
          },
        },
      },
    },
    overrides = function(colors)
      local theme = colors.theme
      return {
        -- Make floating windows transparent
        NormalFloat = { bg = 'none' },
        FloatBorder = { bg = 'none' },
        FloatTitle = { bg = 'none' },

        -- Make completion (popup) menu transparent
        Pmenu = { fg = theme.ui.shade0, bg = 'none' },
        PmenuSbar = { bg = 'none' },
        PmenuThumb = { bg = theme.ui.bg_p2 },

        -- Make popular plugin managers transparent
        LazyNormal = { bg = 'none', fg = theme.ui.fg_dim },
        MasonNormal = { bg = 'none', fg = theme.ui.fg_dim },

        -- Transparent telescope
        TelescopeTitle = { fg = theme.ui.special, bold = true },
        TelescopePromptNormal = { bg = 'none' },
        TelescopePromptBorder = { fg = theme.ui.fg_dim, bg = 'none' },
        TelescopeResultsNormal = { fg = theme.ui.fg_dim, bg = 'none' },
        TelescopeResultsBorder = { fg = theme.ui.fg_dim, bg = 'none' },
        TelescopePreviewNormal = { bg = 'none' },
        TelescopePreviewBorder = { bg = 'none', fg = theme.ui.fg_dim },
      }
    end,
  },
  config = function(_, opts)
    -- Setup kanagawa with our options
    require('kanagawa').setup(opts)

    -- Load the kanagawa-dragon colorscheme
    vim.cmd.colorscheme 'kanagawa-dragon'
  end,
}
-- vim: ts=2 sts=2 sw=2 et
