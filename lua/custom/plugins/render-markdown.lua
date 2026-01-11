-- lua/custom/plugins/render-markdown.lua
-- Plugin to improve viewing Markdown files in Neovim
-- Styled with Kanagawa Dragon colorscheme - Subtle cool palette
-- Optimized for transparent backgrounds with excellent readability
-- See: https://github.com/MeanderingProgrammer/render-markdown.nvim
return {
  'MeanderingProgrammer/render-markdown.nvim',
  -- Lazy load on markdown files for optimal startup time
  ft = { 'markdown' },
  dependencies = {
    'nvim-treesitter/nvim-treesitter', -- Required for parsing markdown
    'nvim-tree/nvim-web-devicons',     -- Optional: for icons above code blocks
  },
  opts = {
    -- Enable rendering by default
    enabled = true,
    -- Maximum file size (in MB) to render
    max_file_size = 10.0,
    -- Render in normal, command, and terminal modes
    render_modes = { 'n', 'c', 't' },
    -- Heading configuration
    heading = {
      enabled = true,
      sign = true,
      -- Icons for each heading level
      icons = { '󰲡 ', '󰲣 ', '󰲥 ', '󰲧 ', '󰲩 ', '󰲫 ' },
      -- Width of heading (no background, so 'block' is fine)
      width = 'block',
      -- No borders needed for minimalist approach
      border = false,
      left_pad = 1,
      right_pad = 1,
    },
    -- Code block configuration
    code = {
      enabled = true,
      sign = true,
      -- Show language name/icon above code blocks
      language_name = true,
      language_icon = true,
      -- Width of code block: 'block' or 'full'
      width = 'full',
      -- Padding for code blocks
      left_pad = 1,
      right_pad = 1,
    },
    -- Bullet list configuration
    bullet = {
      enabled = true,
      -- Icons for nested bullet points
      icons = { '●', '○', '◆', '◇' },
    },
    -- Checkbox configuration
    checkbox = {
      enabled = true,
      unchecked = {
        icon = '󰄱 ',
      },
      checked = {
        icon = '󰱒 ',
      },
    },
    -- Callout blocks (like Obsidian)
    callout = {
      note = { rendered = '󰋽 Note' },
      tip = { rendered = '󰌶 Tip' },
      important = { rendered = '󰅾 Important' },
      warning = { rendered = '󰀪 Warning' },
      caution = { rendered = '󰳦 Caution' },
    },
    -- Anti-conceal: hide rendering on cursor line
    anti_conceal = {
      enabled = true,
      -- Lines above/below cursor to keep rendered
      above = 0,
      below = 0,
    },
    -- LaTeX rendering
    latex = {
      enabled = true,
      -- Converter: 'utftex' or 'latex2text'
      converter = { 'utftex', 'latex2text' },
    },
  },
  config = function(_, opts)
    require('render-markdown').setup(opts)
    -- Kanagawa Dragon color palette (cool-focused, medium intensity)
    -- Optimized for transparent backgrounds with excellent readability
    local dragon_colors = {
      -- Cool palette (primary colors)
      crystal_blue = '#7FB4CA',  -- Bright cool blue
      wave_aqua = '#7AA89F',     -- Aqua/teal
      spring_violet = '#957FB8', -- Cool violet
      dragon_blue = '#658594',   -- Muted blue
      sakura_pink = '#D27E99',   -- Subtle pink
      -- Warm accents (secondary)
      autumn_yellow = '#DCA561', -- Readable warm yellow
      wave_red = '#E46876',      -- Medium red
      -- Backgrounds and borders (for subtle elements)
      sumi_ink_3 = '#181616',    -- Very dark background
      sumi_ink_4 = '#282727',    -- Slightly lighter background
      sumi_ink_6 = '#54546D',    -- Border/inactive color
    }
    -- HEADINGS: Colored text only, no backgrounds (Option A)
    -- Set both Treesitter (for text) and RenderMarkdown (for icons) groups
    -- H1: Crystal Blue
    vim.api.nvim_set_hl(0, '@markup.heading.1.markdown', { fg = dragon_colors.crystal_blue, bold = true })
    vim.api.nvim_set_hl(0, 'RenderMarkdownH1', { fg = dragon_colors.crystal_blue, bold = true })
    -- H2: Wave Aqua
    vim.api.nvim_set_hl(0, '@markup.heading.2.markdown', { fg = dragon_colors.wave_aqua, bold = true })
    vim.api.nvim_set_hl(0, 'RenderMarkdownH2', { fg = dragon_colors.wave_aqua, bold = true })
    -- H3: Spring Violet
    vim.api.nvim_set_hl(0, '@markup.heading.3.markdown', { fg = dragon_colors.spring_violet, bold = true })
    vim.api.nvim_set_hl(0, 'RenderMarkdownH3', { fg = dragon_colors.spring_violet, bold = true })
    -- H4: Dragon Blue (muted)
    vim.api.nvim_set_hl(0, '@markup.heading.4.markdown', { fg = dragon_colors.dragon_blue, bold = true })
    vim.api.nvim_set_hl(0, 'RenderMarkdownH4', { fg = dragon_colors.dragon_blue, bold = true })
    -- H5: Sakura Pink
    vim.api.nvim_set_hl(0, '@markup.heading.5.markdown', { fg = dragon_colors.sakura_pink, bold = true })
    vim.api.nvim_set_hl(0, 'RenderMarkdownH5', { fg = dragon_colors.sakura_pink, bold = true })
    -- H6: Autumn Yellow (warm accent for readability)
    vim.api.nvim_set_hl(0, '@markup.heading.6.markdown', { fg = dragon_colors.autumn_yellow, bold = true })
    vim.api.nvim_set_hl(0, 'RenderMarkdownH6', { fg = dragon_colors.autumn_yellow, bold = true })
    -- CODE BLOCKS: Subtle dark background with colored accents
    vim.api.nvim_set_hl(0, 'RenderMarkdownCode', { bg = dragon_colors.sumi_ink_3 })
    vim.api.nvim_set_hl(0, 'RenderMarkdownCodeInline', { bg = dragon_colors.sumi_ink_4, fg = dragon_colors.wave_aqua })
    -- Code language label: Colored accent (icon + name both colored)
    vim.api.nvim_set_hl(0, 'RenderMarkdownCodeLanguage', { fg = dragon_colors.crystal_blue })
    -- BULLETS: 2-color alternating system (Option A)
    -- Note: RenderMarkdown may not support per-level colors, so this sets the default
    vim.api.nvim_set_hl(0, 'RenderMarkdownBullet', { fg = dragon_colors.crystal_blue })
    -- If the plugin supports it, odd levels will be crystal_blue, even will be wave_aqua
    -- This may require additional configuration in opts if supported
    -- CHECKBOXES: Cool tones
    vim.api.nvim_set_hl(0, 'RenderMarkdownChecked', { fg = dragon_colors.wave_aqua })
    vim.api.nvim_set_hl(0, 'RenderMarkdownUnchecked', { fg = dragon_colors.sumi_ink_6 })
    -- CALLOUTS: Cool-dominant palette
    vim.api.nvim_set_hl(0, 'RenderMarkdownInfo', { fg = dragon_colors.crystal_blue })
    vim.api.nvim_set_hl(0, 'RenderMarkdownSuccess', { fg = dragon_colors.wave_aqua })
    vim.api.nvim_set_hl(0, 'RenderMarkdownHint', { fg = dragon_colors.spring_violet })
    vim.api.nvim_set_hl(0, 'RenderMarkdownWarn', { fg = dragon_colors.autumn_yellow })
    vim.api.nvim_set_hl(0, 'RenderMarkdownError', { fg = dragon_colors.wave_red })
    -- TABLES: Cool professional look
    vim.api.nvim_set_hl(0, 'RenderMarkdownTableHead', { fg = dragon_colors.crystal_blue, bold = true })
    vim.api.nvim_set_hl(0, 'RenderMarkdownTableRow', { fg = dragon_colors.sumi_ink_6 })
    -- LINKS: Pink with underline
    vim.api.nvim_set_hl(0, 'RenderMarkdownLink', { fg = dragon_colors.sakura_pink, underline = true })
    -- BLOCKQUOTES: Subtle cool color (Option B)
    vim.api.nvim_set_hl(0, 'RenderMarkdownQuote', { fg = dragon_colors.dragon_blue })
    -- LATEX/MATH: Cool violet with subtle background
    vim.api.nvim_set_hl(0, 'RenderMarkdownMath', { fg = dragon_colors.spring_violet, bg = dragon_colors.sumi_ink_3 })
    -- HORIZONTAL RULES: Neutral gray (Option A)
    -- Using default styling (no override needed)
    -- Optional: Keymaps for toggling markdown rendering
    vim.keymap.set('n', '<leader>mt', '<cmd>RenderMarkdown toggle<cr>', { desc = '[M]arkdown [T]oggle rendering' })
    vim.keymap.set('n', '<leader>me', '<cmd>RenderMarkdown enable<cr>', { desc = '[M]arkdown [E]nable rendering' })
    vim.keymap.set('n', '<leader>md', '<cmd>RenderMarkdown disable<cr>', { desc = '[M]arkdown [D]isable rendering' })
  end,
}
-- vim: ts=2 sts=2 sw=2 et
