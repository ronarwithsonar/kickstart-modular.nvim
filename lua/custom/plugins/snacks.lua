-- snacks.nvim - Collection of QoL plugins for Neovim
-- Provides dashboard, picker, notifications, and many other improvements
-- See :help snacks.nvim for more information
return {
  'folke/snacks.nvim',
  priority = 1000, -- Load early for quickfile/bigfile to work
  lazy = false,    -- Not lazy-loaded (dashboard needs to be available on startup)
  ---@type snacks.Config
  opts = {
    -- Enable features by including their config
    -- Just having the key present enables the feature (no need for enabled = true)
    dashboard = {
      preset = {
        -- Your custom Neovim ASCII art logo
        header = [[
             ▄ ▄
         ▄   ▄▄▄     ▄ ▄▄▄ ▄ ▄
         █ ▄ █▄█ ▄▄▄ █ █▄█ █ █
      ▄▄ █▄█▄▄▄█ █▄█▄█▄▄█▄▄█ █
    ▄ █▄▄█ ▄ ▄▄ ▄█ ▄▄▄▄▄▄▄▄▄▄▄▄▄▄
    █▄▄▄▄ ▄▄▄ █ ▄ ▄▄▄ ▄ ▄▄▄ ▄ ▄ █ ▄
  ▄ █ █▄█ █▄█ █ █ █▄█ █ █▄█ ▄▄▄ █ █
  █▄█ ▄ █▄▄█▄▄█ █ ▄▄█ █ ▄ █ █▄█▄█ █
      █▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄█ █▄█▄▄▄█
    ]],
        -- Dashboard keys (active within the dashboard)
        keys = {
          { icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
          { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
          { icon = " ", key = "g", desc = "Find Text", action = ":lua Snacks.dashboard.pick('live_grep')" },
          { icon = " ", key = "r", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
          { icon = " ", key = "c", desc = "Config", action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})" },
          { icon = " ", key = "s", desc = "Restore Session", section = "session" },
          { icon = "󰒲 ", key = "L", desc = "Lazy", action = ":Lazy", enabled = package.loaded.lazy ~= nil },
          { icon = " ", key = "q", desc = "Quit", action = ":qa" },
        },
      },
      -- Dashboard layout sections
      sections = {
        { section = 'header' },
        { section = 'keys',   gap = 1, padding = 1 },
        { section = 'startup' },
      },
    },
    -- Other features (presence here = enabled)
    picker = {}, -- CRITICAL - enables the picker feature
    bigfile = {},
    quickfile = {},
    notifier = {},
    input = {},
    bufdelete = {},
    indent = {},
    statuscolumn = {},
    scroll = {},
    words = {},
    gitbrowse = {},
    lazygit = {},
  },
  -- Global keymaps for snacks features
  keys = {
    -- Top-level quick access (most-used)
    {
      '<leader><space>',
      function()
        Snacks.picker.smart()
      end,
      desc = 'Smart Find Files',
    },
    {
      '<leader>,',
      function()
        Snacks.picker.buffers()
      end,
      desc = 'Buffers',
    },
    {
      '<leader>/',
      function()
        Snacks.picker.grep()
      end,
      desc = 'Grep',
    },
    {
      '<leader>:',
      function()
        Snacks.picker.command_history()
      end,
      desc = 'Command History',
    },
    -- Find namespace - File operations
    {
      '<leader>ff',
      function()
        Snacks.picker.files()
      end,
      desc = '[F]ind [F]iles',
    },
    {
      '<leader>fg',
      function()
        Snacks.picker.git_files()
      end,
      desc = '[F]ind [G]it Files',
    },
    {
      '<leader>fr',
      function()
        Snacks.picker.recent()
      end,
      desc = '[F]ind [R]ecent Files',
    },
    {
      '<leader>fb',
      function()
        Snacks.picker.buffers()
      end,
      desc = '[F]ind [B]uffers',
    },
    {
      '<leader>fc',
      function()
        Snacks.picker.files { cwd = vim.fn.stdpath 'config' }
      end,
      desc = '[F]ind [C]onfig Files',
    },
    -- Search namespace - Content search
    {
      '<leader>sg',
      function()
        Snacks.picker.grep()
      end,
      desc = '[S]earch by [G]rep',
    },
    {
      '<leader>sw',
      function()
        Snacks.picker.grep_word()
      end,
      desc = '[S]earch current [W]ord',
      mode = { 'n', 'x' },
    },
    {
      '<leader>sb',
      function()
        Snacks.picker.lines()
      end,
      desc = '[S]earch [B]uffer Lines',
    },
    {
      '<leader>sB',
      function()
        Snacks.picker.grep_buffers()
      end,
      desc = '[S]earch in Open [B]uffers',
    },
    {
      '<leader>sh',
      function()
        Snacks.picker.help()
      end,
      desc = '[S]earch [H]elp',
    },
    {
      '<leader>sk',
      function()
        Snacks.picker.keymaps()
      end,
      desc = '[S]earch [K]eymaps',
    },
    {
      '<leader>sd',
      function()
        Snacks.picker.diagnostics()
      end,
      desc = '[S]earch [D]iagnostics',
    },
    {
      '<leader>ss',
      function()
        Snacks.picker.lsp_symbols()
      end,
      desc = '[S]earch LSP [S]ymbols',
    },
    {
      '<leader>sr',
      function()
        Snacks.picker.resume()
      end,
      desc = '[S]earch [R]esume',
    },
    {
      '<leader>su',
      function()
        Snacks.picker.undo()
      end,
      desc = '[S]earch [U]ndo History',
    },
    {
      '<leader>sm',
      function()
        Snacks.picker.marks()
      end,
      desc = '[S]earch [M]arks',
    },
    {
      '<leader>sj',
      function()
        Snacks.picker.jumps()
      end,
      desc = '[S]earch [J]umps',
    },
    {
      '<leader>sq',
      function()
        Snacks.picker.qflist()
      end,
      desc = '[S]earch [Q]uickfix List',
    },
    -- Git namespace
    {
      '<leader>gg',
      function()
        Snacks.lazygit()
      end,
      desc = 'Lazygit',
    },
    {
      '<leader>gB',
      function()
        Snacks.gitbrowse()
      end,
      desc = 'Git [B]rowse',
      mode = { 'n', 'v' },
    },
    {
      '<leader>gb',
      function()
        Snacks.picker.git_branches()
      end,
      desc = 'Git [B]ranches',
    },
    {
      '<leader>gl',
      function()
        Snacks.picker.git_log()
      end,
      desc = 'Git [L]og',
    },
    {
      '<leader>gs',
      function()
        Snacks.picker.git_status()
      end,
      desc = 'Git [S]tatus',
    },
    {
      '<leader>gd',
      function()
        Snacks.picker.git_diff()
      end,
      desc = 'Git [D]iff (Hunks)',
    },
    -- LSP (using standard vim conventions)
    {
      'gd',
      function()
        Snacks.picker.lsp_definitions()
      end,
      desc = 'Goto Definition',
    },
    {
      'gr',
      function()
        Snacks.picker.lsp_references()
      end,
      desc = 'Goto References',
      nowait = true,
    },
    {
      'gI',
      function()
        Snacks.picker.lsp_implementations()
      end,
      desc = 'Goto Implementation',
    },
    {
      'gy',
      function()
        Snacks.picker.lsp_type_definitions()
      end,
      desc = 'Goto Type Definition',
    },
    -- LSP Reference Navigation (words feature)
    {
      ']]',
      function()
        Snacks.words.jump(vim.v.count1)
      end,
      desc = 'Next Reference',
      mode = { 'n', 't' },
    },
    {
      '[[',
      function()
        Snacks.words.jump(-vim.v.count1)
      end,
      desc = 'Prev Reference',
      mode = { 'n', 't' },
    },
    -- Buffer Management
    {
      '<leader>bd',
      function()
        Snacks.bufdelete()
      end,
      desc = '[B]uffer [D]elete',
    },
    -- Notifications
    {
      '<leader>un',
      function()
        Snacks.notifier.hide()
      end,
      desc = 'Dismiss All Notifications',
    },
    {
      '<leader>nh',
      function()
        Snacks.notifier.show_history()
      end,
      desc = '[N]otification [H]istory',
    },
    -- Utility
    {
      '<leader>z',
      function()
        Snacks.zen()
      end,
      desc = 'Toggle Zen Mode',
    },
    {
      '<leader>.',
      function()
        Snacks.scratch()
      end,
      desc = 'Toggle Scratch Buffer',
    },
    {
      '<leader>S',
      function()
        Snacks.scratch.select()
      end,
      desc = 'Select Scratch Buffer',
    },
    -- Terminal
    {
      '<c-/>',
      function()
        Snacks.terminal()
      end,
      desc = 'Toggle Terminal',
    },
    {
      '<c-_>',
      function()
        Snacks.terminal()
      end,
      desc = 'which_key_ignore',
    },
  },
}
-- vim: ts=2 sts=2 sw=2 et
