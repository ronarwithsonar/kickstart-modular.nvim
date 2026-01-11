-- Kanagawa colorscheme - dragon variant with maximum transparency
-- Background transparency enabled to match terminal's kanagawa-dragon theme
return {
  'rebelot/kanagawa.nvim',
  priority = 1000,      -- Load before other plugins to ensure theme applies first
  opts = {
    transparent = true, -- Enable transparent background
    theme = 'dragon',   -- Explicitly set dragon theme
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

        -- Snacks Dashboard customizations (using Kanagawa Dragon palette)
        SnacksDashboardNormal = { fg = theme.ui.fg, bg = 'none' },         -- Keep transparent bg
        SnacksDashboardHeader = { fg = theme.syn.string, bold = true },    -- Use function blue for ASCII art
        SnacksDashboardIcon = { fg = theme.syn.special1 },                 -- Special orange/yellow for icons
        SnacksDashboardKey = { fg = theme.syn.keyword, bold = true },      -- Keyword purple for keys
        SnacksDashboardDesc = { fg = theme.ui.fg_dim },                    -- Dimmed foreground for descriptions
        SnacksDashboardFooter = { fg = theme.syn.comment, italic = true }, -- Comment gray for footer
        SnacksDashboardDir = { fg = theme.syn.identifier },                -- Identifier color for directories
        SnacksDashboardFile = { fg = theme.ui.fg },                        -- Normal foreground for files

        -- Snacks Picker customizations (using Kanagawa Dragon palette)
        -- Main windows
        SnacksPickerNormal = { fg = theme.ui.fg, bg = 'none' },             -- Main picker background
        SnacksPickerBorder = { fg = theme.ui.special, bg = 'none' },        -- Border color
        SnacksPickerTitle = { fg = theme.syn.fun, bold = true },            -- Title bar
        -- Input window
        SnacksPickerInput = { fg = theme.ui.fg, bg = 'none' },              -- Input text
        SnacksPickerPrompt = { fg = theme.syn.special1, bold = true },      -- Prompt icon
        -- Results list
        SnacksPickerMatch = { fg = theme.syn.special1, bold = true },       -- Matched characters
        SnacksPickerCursor = { fg = theme.syn.keyword, bold = true },       -- Current selection
        SnacksPickerDir = { fg = theme.syn.identifier },                    -- Directory paths
        SnacksPickerFile = { fg = theme.ui.fg },                            -- File names
        SnacksPickerIcon = { fg = theme.syn.special1 },                     -- File icons
        SnacksPickerSelected = { fg = theme.syn.keyword },                  -- Selected items
        -- Preview window
        SnacksPickerPreview = { fg = theme.ui.fg, bg = 'none' },            -- Preview text
        SnacksPickerPreviewBorder = { fg = theme.ui.special, bg = 'none' }, -- Preview border
        -- Special elements
        SnacksPickerLiveGrep = { fg = theme.syn.string, italic = true },    -- Live grep indicator
        SnacksPickerCount = { fg = theme.syn.comment },                     -- Item count
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
