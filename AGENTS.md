# AGENTS.md - Developer Guide for AI Coding Agents

## Overview

This is a **kickstart-modular.nvim** configuration - a modular, educational Neovim setup based on kickstart.nvim. Unlike a complete Neovim distribution, this configuration serves as a learning foundation that explains every choice through inline documentation.

**Philosophy**: This codebase prioritizes clarity, modularity, and education over feature completeness. Every configuration choice is documented with comments explaining the "why" behind decisions.

**Target Audience**: This guide is written for AI coding agents working in this repository to help maintain consistency and quality.

**For Users**: See `README.md` for installation instructions and user-facing documentation.

---

## Working with This Codebase

### Communication Guidelines for Agents

When providing feedback, suggestions, or implementing changes:

- **Always include relevant code examples** when making recommendations
- **Reference specific files and line numbers** using the format `file_path:line_number`
- **Show before/after comparisons** when suggesting modifications
- **Explain the "why"** behind recommendations, not just the "what"
- **Follow the educational tone** of this codebase - help users learn, don't just fix

---

## Build/Lint/Test Commands

### Formatting with StyLua

This configuration uses **StyLua** for Lua code formatting with specific style rules defined in `.stylua.toml`.

**Commands**:
- Format all files: `stylua .`
- Check formatting without changes: `stylua --check .`
- Format specific file: `stylua lua/options.lua`

**Configuration** (`.stylua.toml`):
- Column width: 160 characters
- Indentation: 2 spaces
- Line endings: Unix (LF)
- Quote style: Single quotes preferred
- Call parentheses: Not required for single string/table arguments

**CI/CD**: GitHub Actions automatically checks formatting on pull requests via `.github/workflows/stylua.yml`.

**Recommendation**: Always format code with StyLua before committing changes.

### Health Checks

Neovim provides built-in diagnostics through the `:checkhealth` system. Always run health checks after making configuration changes.

**Commands**:
- General health check: `:checkhealth`
- Config-specific check: `:checkhealth kickstart`
- Plugin manager: `:checkhealth lazy`
- LSP diagnostics: `:checkhealth vim.lsp`
- Tool installer: `:checkhealth mason`

**Headless mode** (for automation/testing):
```bash
nvim --headless "+checkhealth" +qa
```

### Testing Strategies

This configuration doesn't include a formal test suite, but manual testing is critical.

**Basic Validation**:
```bash
# Test plugin synchronization
nvim --headless -c "Lazy! sync" +qa

# Combined health check (exit code indicates success/failure)
nvim --headless "+checkhealth" +qa
```

**Isolated Plugin Testing**:
- Launch with clean config: `nvim --clean`
- Test with minimal config: Create `minimal_test.lua` that loads only the plugin under test
- Load minimal config: `nvim -u minimal_test.lua`

**Manual Testing Workflow**:
1. Make configuration change
2. Reload config in running Neovim: `:source %` (if in init.lua or module file)
3. Test the specific feature modified
4. Run `:checkhealth` to catch issues
5. Test keymaps: Press keys and verify behavior
6. Test LSP: Open various filetypes, verify LSP attaches (`:LspInfo`)
7. Restart Neovim for full integration test

**Performance Testing**:
- Analyze startup time: `:Lazy profile`
- Identify slow plugins
- Optimize lazy loading configuration

**Keymap Testing**:
- View specific keymap: `:map <leader>ff`
- Search all keymaps: `:Telescope keymaps`
- Verify no conflicts: Check which-key display

### Plugin Management

This configuration uses **lazy.nvim** as the plugin manager.

**Commands**:
- Interactive UI: `:Lazy`
- Sync plugins (install/update): `:Lazy sync`
- Remove unused plugins: `:Lazy clean`
- Restore from lockfile: `:Lazy restore`
- View logs: `:Lazy log`
- Profile startup time: `:Lazy profile`

**Lock File**: `lazy-lock.json`
- **MUST be tracked in version control**
- Ensures reproducible plugin versions across installations
- Updated automatically when plugins change
- Restore exact versions: `:Lazy restore`

---

## Codebase Structure

### Directory Overview

```
/Users/ronanmclaughlin/dotfiles/.config/nvim/
├── init.lua                    # Entry point: sets leader keys, loads modules
├── lazy-lock.json             # Plugin version lockfile (TRACK IN GIT)
├── README.md                  # User-facing documentation
├── LICENSE.md                 # MIT license
├── .stylua.toml              # StyLua formatter configuration
├── .gitignore                 # Git ignore rules
│
├── .github/
│   ├── workflows/
│   │   └── stylua.yml        # CI: Formatting checks on PRs
│   ├── ISSUE_TEMPLATE/
│   │   └── bug_report.md     # Bug report template
│   └── pull_request_template.md
│
├── doc/
│   ├── kickstart.txt         # Vim help documentation (:help kickstart)
│   └── tags                  # Help tags index
│
└── lua/
    ├── options.lua           # Editor settings (line numbers, tabs, etc.)
    ├── keymaps.lua           # Global keybindings and autocommands
    ├── lazy-bootstrap.lua    # Auto-installs lazy.nvim if missing
    ├── lazy-plugins.lua      # Plugin loader and UI configuration
    │
    ├── kickstart/
    │   ├── health.lua        # Custom health checks for dependencies
    │   └── plugins/          # Plugin configurations (one per file)
    │       ├── lspconfig.lua      # LSP configuration with Mason
    │       ├── telescope.lua      # Fuzzy finder
    │       ├── treesitter.lua     # Syntax highlighting
    │       ├── cmp.lua            # Autocompletion
    │       ├── which-key.lua      # Keymap helper
    │       ├── gitsigns.lua       # Git integration
    │       ├── conform.lua        # Code formatting
    │       ├── tokyonight.lua     # Color scheme
    │       ├── mini.lua           # Collection of mini plugins
    │       ├── todo-comments.lua  # TODO highlighting
    │       ├── autopairs.lua      # Auto-close brackets (optional)
    │       ├── debug.lua          # DAP debugging (optional)
    │       ├── indent_line.lua    # Indentation guides (optional)
    │       ├── lint.lua           # Linting (optional)
    │       └── neo-tree.lua       # File explorer (optional)
    │
    └── custom/
        └── plugins/
            └── init.lua      # USER'S custom plugins go here
```

### Modular Architecture Philosophy

**One concern per file**: Each aspect of configuration lives in its own module.

**One plugin per file**: Every plugin has a dedicated file in `kickstart/plugins/` for clarity.

**Separation of core vs custom**:
- `kickstart/` - Core configuration provided by kickstart-modular
- `custom/` - User's personal additions and modifications
- This separation allows pulling upstream updates without conflicts

**Why modularity matters**:
- Easier to understand: Each file has a single purpose
- Better git diffs: Changes are isolated to relevant files
- Maintainability: Find and modify specific features quickly
- Learning: New users can study one plugin at a time

### Load Order

Configuration loads in this specific order (see `init.lua:97-106`):

1. **Leader keys** (`init.lua:90-94`) - Set before plugins load
2. **Options** (`lua/options.lua`) - Editor settings
3. **Keymaps** (`lua/keymaps.lua`) - Global keybindings
4. **Lazy bootstrap** (`lua/lazy-bootstrap.lua`) - Install plugin manager
5. **Lazy plugins** (`lua/lazy-plugins.lua`) - Load all plugin configurations

**Why this order matters**: Plugins may use leader key in their configuration, so it must be set first.

### Where to Make Changes

**Adding new plugins**:
- Create file in `lua/custom/plugins/` with plugin name: `lua/custom/plugins/my-plugin.lua`
- Return a lazy.nvim plugin spec table
- Lazy.nvim automatically loads all files in this directory

**Modifying existing plugins**:
- Edit the corresponding file in `lua/kickstart/plugins/`
- Be aware this makes pulling upstream updates more complex

**Global editor options**:
- Modify `lua/options.lua`
- See `:help vim.opt` for available options

**Global keymaps**:
- Add to `lua/keymaps.lua`
- Plugin-specific keymaps belong in the plugin's config file

**Plugin-specific keymaps**:
- Add inside the plugin's `config` function or `keys` table
- Keep related keymaps close to the plugin configuration

**DO NOT modify**:
- `lua/lazy-bootstrap.lua` - Only touch if you know what you're doing
- `lazy-lock.json` manually - Let lazy.nvim manage this file

---

## Code Style Guidelines

### File Organization

**Module pattern**: Every Lua file is a module that returns a table.

**Plugin files**: Return a lazy.nvim plugin spec (table or array of tables).

**Modeline**: End every file with this comment to ensure consistent editing:
```lua
-- vim: ts=2 sts=2 sw=2 et
```

**Load order awareness**: Some modules depend on others being loaded first. See `init.lua` for the canonical load order.

### Import/Require Patterns

This codebase uses three distinct require patterns depending on the use case:

**Style 1: No parentheses, no assignment**
- Use when: Loading a module for side effects only
- Pattern: `require 'module'`
- Example: `init.lua:97-106`

**Style 2: Immediate setup with parentheses**
- Use when: Calling setup function immediately
- Pattern: `require('module').setup({...})`
- Example: `lua/lazy-plugins.lua:12`

**Style 3: Local assignment**
- Use when: Storing module reference for multiple uses
- Pattern: `local mod = require 'module'`
- Example: `lua/kickstart/plugins/telescope.lua:77` (builtin), `lua/kickstart/plugins/cmp.lua:40-41`

**When to use each**:
- Use Style 1 for top-level module loading (init.lua)
- Use Style 2 when setting up plugins inline
- Use Style 3 when you need to call multiple functions from the module

### Naming Conventions

**CRITICAL**: Always use `snake_case` for everything in Lua. This is Lua convention.

**Variables**: `local lazypath = ...`, `highlight_augroup`, `ensure_installed`

**Functions**: `local function map(keys, func, desc) ... end`

**Files**: `lspconfig.lua`, `lazy-plugins.lua`, `todo-comments.lua`

**Constants**: Still `snake_case` (Lua doesn't distinguish constants from variables)

**Prefer descriptive over terse**:
- Good: `highlight_augroup`, `telescope_builtin`
- Avoid: `hl_grp`, `tel_b`

**Local variables preferred**: Always use `local` unless you specifically need global scope.

### Function Definitions

**Prefer local functions**:
```lua
local function map(keys, func, desc)
  -- implementation
end
```

**Anonymous functions for callbacks**:
- Common pattern for autocommands, plugin configs, keymaps
- See `lua/keymaps.lua:40-46` (TextYankPost autocommand)

**Factory pattern for helper functions**:
- Create helper functions inside plugin config functions
- Captures local variables in closure
- See `lua/kickstart/plugins/lspconfig.lua:70-73` (map function)
- See `lua/kickstart/plugins/gitsigns.lua:20-24` (map function with buffer)

**Avoid global functions**: Polluting global namespace causes conflicts.

### Table and Module Patterns

**Module export pattern**: Every module returns a table.

**Plugin spec structure**:
```lua
return {
  'author/plugin-name',
  dependencies = { 'dep1', 'dep2' },
  event = 'VimEnter',
  opts = {
    -- passed to setup()
  },
}
```

**Nested tables for configuration**: Lua tables are versatile data structures.

**Comma-trailing allowed**: Trailing commas prevent git diffs when adding items.

**Array-like vs dictionary-like**:
- Array: `{ 'item1', 'item2' }` - Sequential numeric indices
- Dictionary: `{ key1 = 'value1', key2 = 'value2' }` - Named keys

### Comment Style and Documentation

**Block comments for file headers**:
```lua
--[[
Multi-line
documentation
--]]
```

**Section markers**:
```lua
-- [[ Section Name ]]
```

**Inline comments**: Always use space after `--`
```lua
-- This is a proper inline comment
```

**Callout prefixes**:
- `NOTE:` - Important information
- `TIP:` - Helpful suggestions
- `WARN:` - Warnings about gotchas

**Help references**: Point users to Neovim help system
```lua
-- See :help vim.opt
-- For more: :help option-list
```

**Explain WHY, not WHAT**: Code shows what it does; comments explain why.

**Multi-line explanations**: Add above complex logic blocks.
- See `lua/kickstart/plugins/lspconfig.lua:58-61` for excellent example

**Document configuration choices**: Explain why you chose specific values or approaches.

### Error Handling

**pcall for optional features**:
- Pattern: `pcall(func, args)`
- Use when: Loading optional extensions, features that may not be available
- Example: `lua/kickstart/plugins/telescope.lua:73-74` (loading telescope extensions)

**Conditional checks before operations**:
```lua
if vim.fn.executable 'make' == 1 then
  -- safe to use make
end
```

**Early returns for guard clauses**:
```lua
if not condition then
  return
end
-- main logic here
```

**error() for critical failures**:
- Only use when failure is unrecoverable
- Example: `lua/lazy-bootstrap.lua:7-9` (failed to clone lazy.nvim)

**Safe method checking**:
- Before calling LSP methods, check support
- Pattern: `if client and client.supports_method(...) then`
- Example: `lua/kickstart/plugins/lspconfig.lua:118`

### Lua Idioms

**Ternary-like expressions**:
```lua
value = condition and true_val or false_val
```
Warning: Fails if `true_val` is false or nil. Use carefully.

**Table manipulation**: Use `vim.tbl_*` helper functions
- `vim.tbl_deep_extend()` - Deep merge tables
- `vim.tbl_keys()` - Extract keys as array
- `vim.tbl_values()` - Extract values as array

**String concatenation**: Use `..` operator
```lua
local path = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
```

**Schedule async operations**:
```lua
vim.schedule(function()
  -- async code
end)
```
Example: `lua/options.lua:22-24` (clipboard setting)

**Diagnostic disable annotations**:
```lua
---@diagnostic disable-next-line: undefined-field
```
Use sparingly, only when you know the diagnostic is incorrect.

---

## Plugin Development Patterns

### Lazy.nvim Plugin Spec Structure

A plugin spec is a Lua table with the following structure:

**Required field**:
- String: Plugin repository in format `'author/plugin-name'` or `'plugin-name'` for vim.org

**Optional but common fields**:

- `dependencies` - Array of plugin specs that must load first
- `event` - String or array of events to trigger loading
- `cmd` - String or array of commands to trigger loading
- `ft` - String or array of filetypes to trigger loading
- `keys` - String, array, or table of keymaps to trigger loading
- `build` - Command to run after install/update
- `opts` - Table passed to `require('plugin').setup(opts)`
- `config` - Function called to configure plugin
- `enabled` - Boolean or function to conditionally enable plugin
- `lazy` - Boolean to override lazy loading behavior
- `priority` - Number for load order (higher = earlier, default 50)
- `main` - String module name to use for setup (instead of plugin name)

**Examples**:
- Simple: `lua/kickstart/plugins/tokyonight.lua`
- Complex: `lua/kickstart/plugins/telescope.lua`
- With dependencies: `lua/kickstart/plugins/lspconfig.lua`

### Lazy Loading: Why and How

**Why lazy loading matters**:
- Faster startup time: Only load plugins when needed
- Better resource usage: Don't load unused features
- Critical for good Neovim UX: Sub-100ms startup feels instant

**Default behavior**: lazy.nvim lazy loads by default unless:
- Plugin is a dependency
- Plugin has no lazy loading triggers (event, cmd, ft, keys)

**Event-based loading** (most common):
- `VimEnter` - After Neovim finishes starting (use for UI plugins)
- `InsertEnter` - When entering insert mode (use for completion)
- `BufReadPre` - Before reading any buffer
- `BufReadPost` - After reading any buffer
- `LspAttach` - When LSP client attaches
- Full list: `:help autocmd-events`

**Command-based loading**:
- Specify command name: `cmd = 'Telescope'`
- Plugin loads when command is first executed
- Perfect for tools you invoke manually

**Filetype-based loading**:
- Specify filetypes: `ft = { 'lua', 'vim' }`
- Plugin loads only for those file types
- Great for language-specific plugins

**Key-based loading**:
- Specify keymap: `keys = '<leader>ff'`
- Plugin loads when key is pressed
- Can include full keymap spec with mode and opts

**Finding the right trigger**:
- Ask: "When does the user first need this plugin?"
- Too early: Slows startup unnecessarily
- Too late: User sees error or lag

### opts vs config

**opts table (simple configuration)**:
- Equivalent to calling `require('plugin').setup(opts)`
- Use when: Plugin has straightforward setup function
- Keeps configuration concise
- Example: `lua/kickstart/plugins/which-key.lua:9`

**config function (complex configuration)**:
- Function called after plugin loads
- Use when you need to:
  - Call multiple setup functions
  - Set keymaps after plugin loads
  - Conditional configuration logic
  - Load extensions
  - Complex multi-step setup
- Example: `lua/kickstart/plugins/telescope.lua:33-111`

**When opts isn't enough**:
- If you need anything besides `require('plugin').setup(opts)`, use `config`
- If you need to require multiple modules, use `config`
- If you need to set keymaps specific to this plugin, use `config`

**NOTE**: `opts = {}` is valid and means "call setup with empty table". Many plugins require calling setup even with no options.

### Adding New Plugins Workflow

**Step 1: Create plugin file**
- Location: `lua/custom/plugins/plugin-name.lua`
- Use kebab-case for filenames
- Match the plugin's common name

**Step 2: Write plugin spec**
```lua
return {
  'author/plugin-name',
  -- add appropriate lazy loading triggers
  -- add configuration
}
```

**Step 3: Test installation**
- Restart Neovim (or `:source` the plugin file)
- Run `:Lazy sync` to install
- Watch for errors in `:Lazy` UI

**Step 4: Verify functionality**
- Run `:checkhealth plugin-name` if available
- Test the plugin's features manually
- Check keymaps work: `:Telescope keymaps`

**Step 5: Document your choices**
- Add comments explaining why you chose this plugin
- Document any non-obvious configuration
- Explain lazy loading strategy

**Step 6: Commit changes**
- Format code: `stylua .`
- Stage files: Plugin file and `lazy-lock.json`
- Commit with descriptive message

### Plugin Dependencies

**Nested dependency tables**:
- Dependencies load before the parent plugin
- Can have their own specs (build, config, opts, etc.)
- Can have their own dependencies (nested deeper)

**Example structure**:
```lua
dependencies = {
  'simple-dependency',
  {
    'complex-dependency',
    build = 'make',
    opts = {},
  },
}
```

**Real-world example**: See `lua/kickstart/plugins/telescope.lua:13-32`
- telescope-fzf-native with build command
- telescope-ui-select with simple spec
- nvim-web-devicons with conditional enable

**Dependency loading order**:
1. Dependencies load recursively (depth-first)
2. Parent plugin loads after all dependencies
3. Parent's `config` function runs last

---

## Keymap Conventions

### Leader Key

**Space bar as leader**: `vim.g.mapleader = ' '`
- Set in `init.lua:90-94`
- Must be set **before** lazy.nvim loads plugins
- Many plugins use leader key during setup

**Local leader**: `vim.g.maplocalleader = ' '`
- Used for filetype-specific mappings
- Same as leader in this config

**Why set before plugins load**: Plugin configs may create keymaps using leader during initialization.

### Keymap Definition

**Signature**: `vim.keymap.set(mode, lhs, rhs, opts)`

**Parameters**:
- `mode` - String or table: `'n'` (normal), `'v'` (visual), `'i'` (insert), or `{ 'n', 'v' }` (multiple)
- `lhs` - Key sequence (left-hand side): `'<leader>ff'`, `'<C-d>'`, etc.
- `rhs` - Action (right-hand side): String command or Lua function
- `opts` - Table with optional fields: `desc`, `buffer`, `silent`, `noremap`, etc.

**Example**: `lua/kickstart/plugins/telescope.lua:78`

### Description Convention

**ALWAYS provide desc**: Every keymap needs a description.

**Mnemonic bracket notation**:
- Format: `[S]earch [F]iles` highlights letters `sf` in which-key
- Helps users remember keymaps
- Makes which-key display more useful

**Style guidelines**:
- Capitalize first letter
- Keep it short: 3-5 words maximum
- Be descriptive: User should understand without trying it
- Use prefix for namespacing: `LSP: [G]oto [D]efinition`

**Examples** from `lua/kickstart/plugins/telescope.lua:78-89`:
- `[S]earch [H]elp` for `<leader>sh`
- `[S]earch [K]eymaps` for `<leader>sk`
- `[S]earch [F]iles` for `<leader>sf`

### Buffer-local vs Global Keymaps

**Global keymaps**:
- Available in all buffers
- Most keymaps are global
- Set with: `vim.keymap.set(mode, lhs, rhs, { desc = '...' })`

**Buffer-local keymaps**:
- Only active in specific buffer
- Common for LSP keymaps (per-buffer LSP client)
- Set with: `vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = '...' })`

**When to use buffer-local**:
- LSP keymaps: Different languages may have different capabilities
- Filetype-specific features
- Temporary keymaps for specific buffers

**Example**: See `lua/kickstart/plugins/lspconfig.lua:58-170` for LSP buffer-local keymaps.

### Keymap Testing and Conflicts

**Check if keymap exists**:
- Specific key: `:map <leader>ff`
- All in mode: `:nmap` (normal), `:vmap` (visual), `:imap` (insert)
- Search all: `:Telescope keymaps`

**which-key displays conflicts**: When you press leader, which-key shows available keys and highlights conflicts.

**Avoid conflicts**:
- Check before adding new keymaps
- Use namespaces: `<leader>s` for search, `<leader>g` for git, etc.
- Follow existing patterns in the config

---

## Autocommands and Events

### Autocommand Pattern

**Signature**: `vim.api.nvim_create_autocmd(event, opts)`

**Parameters**:
- `event` - String or array of event names
- `opts` - Table with fields:
  - `callback` - Function to run (required unless `command` provided)
  - `group` - Augroup for organization
  - `pattern` - Pattern to match (e.g., `*.lua`)
  - `desc` - Description of what this autocommand does
  - `buffer` - Buffer number for buffer-local autocommand
  - `once` - Boolean, run only once

**Example**: See `lua/keymaps.lua:40-46` (highlight on yank)

### Augroups

**Always use augroups**: Organize related autocommands together.

**Creating augroup**: `vim.api.nvim_create_augroup(name, { clear = true })`

**Clear flag**:
- `clear = true` - Remove existing autocommands when reloading
- `clear = false` - Preserve existing (useful for conditional adds)

**Why augroups matter**:
- Prevents duplicate autocommands on config reload
- Organizes related autocommands
- Allows bulk removal/disable

**Example**: See `lua/kickstart/plugins/lspconfig.lua:63` (lsp-attach augroup)

### Common Events

**TextYankPost** - After yanking text (see `lua/keymaps.lua:40`)

**LspAttach** - When LSP client attaches to buffer (see `lua/kickstart/plugins/lspconfig.lua:62`)

**BufWritePre** - Before writing buffer (useful for format-on-save)

**BufReadPost** - After reading buffer into window

**CursorHold** - Cursor hasn't moved for `updatetime` milliseconds

**InsertEnter** / **InsertLeave** - Entering/leaving insert mode

**VimEnter** - After Neovim finishes starting up

**FileType** - When filetype is set

**Full list**: `:help autocmd-events`

### Event-based Plugin Loading vs Autocommands

**Don't confuse these concepts**:

**Plugin `event` field** (in plugin spec):
- Controls when plugin code loads
- Defers plugin loading until event occurs
- Improves startup time

**Autocommands**:
- Run code when event occurs
- Used for custom behavior on events
- Separate concept from plugin loading

**Example**:
- Plugin loads on `InsertEnter` event (plugin spec)
- Autocommand runs on `TextYankPost` event (autocommand)
- These are independent mechanisms

---

## Common Pitfalls and Best Practices

### Pitfalls to Avoid

❌ **Skipping `:checkhealth` after changes**
- Always run health checks after modifying config
- Catches missing dependencies, configuration errors
- Run `:checkhealth kickstart` for config-specific checks

❌ **Not tracking `lazy-lock.json` in git**
- This file ensures reproducible plugin versions
- Without it, plugin versions drift between machines
- Always commit lockfile changes with config changes

❌ **Using global functions**
- Pollutes global namespace
- Causes conflicts between plugins
- Always use `local function` instead

❌ **Editing files without reading inline documentation first**
- This config has extensive inline comments
- Comments explain the "why" behind choices
- Read before modifying to understand context

❌ **Creating keymaps without `desc` field**
- Descriptions are critical for discoverability
- which-key displays descriptions
- Future you will thank present you

❌ **Forgetting to set leader key before loading plugins**
- Leader must be set before `lazy.nvim` loads (see `init.lua:90-94`)
- Plugins may use leader during setup
- Setting after causes unexpected behavior

❌ **Not testing changes before committing**
- Test incrementally: Small change → test → commit
- Run `:checkhealth` after changes
- Verify keymaps work as expected

❌ **Modifying `lazy-bootstrap.lua` unnecessarily**
- This file is critical for plugin manager installation
- Only modify if you understand lazy.nvim internals
- Most changes should be in plugin configs, not bootstrap

❌ **Using `require` inside plugin `opts` table**
- `opts` is data, not code
- Use `config` function if you need to require modules
- Example: Don't put `require` calls in `opts` values

### Best Practices

✅ **Always run `:checkhealth` after config changes**
- Catches issues early
- Validates dependencies
- Confirms plugins loaded correctly

✅ **Format with StyLua before committing**
- Maintains consistent style
- Prevents style-related diffs
- Run: `stylua .`

✅ **Test incrementally**
- Make small change
- Test thoroughly
- Commit if working
- Repeat
- Avoid large uncommitted changes

✅ **Read existing plugin configs before modifying**
- Learn from existing patterns
- Understand why current configuration exists
- Follow established conventions

✅ **Use descriptive names and comments**
- Future maintainers (including you) will appreciate it
- Explain "why" in comments, code shows "what"
- Use full words over abbreviations

✅ **Leverage lazy loading for better startup time**
- Use `event`, `cmd`, `ft`, `keys` appropriately
- Check startup time: `:Lazy profile`
- Defer loading until actually needed

✅ **Check keymap conflicts**
- Before adding keymap: `:map <leader>x`
- Search all keymaps: `:Telescope keymaps`
- Follow existing namespace conventions

✅ **Use `:Lazy profile` to debug slow startup**
- Identifies slowest plugins
- Helps optimize lazy loading
- Target: Sub-100ms startup time

✅ **Document WHY you made changes**
- Git commit messages should explain reasoning
- Inline comments should explain choices
- Help future maintainers understand context

✅ **Reference help docs**
- `:help` is comprehensive and well-written
- Always check `:help option-name` before modifying
- Learn Neovim deeply by reading help

✅ **Keep `custom/` separate from `kickstart/`**
- Easier to pull upstream updates
- Clear separation of personal vs base config
- Merge conflicts less likely

### Debugging Tips

**View error messages**: `:messages`
- Shows all messages including errors
- Useful when something fails silently

**Plugin installation logs**: `:Lazy log`
- See what happened during plugin install/update
- Identify build failures

**LSP status**: `:LspInfo`
- Shows attached LSP clients
- Displays client capabilities
- Confirms LSP is working

**Find all diagnostics**: `:Telescope diagnostics`
- Search all errors/warnings across project
- Jump directly to issues

**Debug print in Lua**: `vim.print(value)`
- Inspect values during development
- Output appears in `:messages`

**Reload configuration**: `:source %`
- Reload current file
- Useful for iterating on config
- Note: Not all changes take effect without restart

---

## Backup and Restore Strategies

### Configuration Backup

**Version Control (Primary Method)**:
- Entire config is in git (dotfiles repository)
- Commit before making major changes
- Use branches for experimental features
- Push regularly to remote backup

**Recommended workflow**:
```bash
# Before major changes
git checkout -b test-new-feature

# Make changes, test thoroughly

# If successful
git checkout main
git merge test-new-feature

# If unsuccessful
git checkout main
git branch -D test-new-feature
```

**Plugin State**:
- `lazy-lock.json` locks exact plugin versions
- Commit lockfile with config changes
- Restore exact state: `:Lazy restore`
- This ensures reproducible builds across machines

### Disaster Recovery

**Rollback config changes**:
```bash
# Find working commit
git log --oneline

# Restore specific file
git checkout <commit-hash> -- lua/options.lua

# Or revert entire commit
git revert <commit-hash>
```

**Restore to known-good state**:
```bash
# Nuclear option: reset to commit
git reset --hard <commit-hash>

# Then restore plugins
nvim --headless -c "Lazy restore" +qa
```

**After rollback**:
- Open Neovim
- Run `:Lazy sync` to update plugins
- Run `:checkhealth` to verify everything works

### Fresh Install

**When config is completely broken**:

```bash
# Backup current config (just in case)
mv ~/.config/nvim ~/.config/nvim.broken

# Clone fresh config
git clone <your-dotfiles-repo> ~/.config/nvim

# Open Neovim (plugins auto-install via lazy-bootstrap)
nvim

# Verify installation
:checkhealth
:Lazy sync
```

**Plugin cache issues**:

Sometimes plugin cache gets corrupted. Clear it:

```bash
# Clear plugin cache
rm -rf ~/.local/share/nvim

# Clear state data
rm -rf ~/.local/state/nvim

# Reopen Neovim (reinstalls everything)
nvim

# Run sync
:Lazy sync
```

**Effect**: Fresh plugin installs, like first-time setup.

### Testing Before Committing

**Use test branches for safety**:

```bash
# Create test branch
git checkout -b test-changes

# Make changes, test thoroughly in Neovim

# If broken: instant rollback
git checkout main

# If working: merge changes
git checkout main
git merge test-changes
```

**Test checklist**:
- [ ] Config loads without errors
- [ ] `:checkhealth` passes (or explains expected failures)
- [ ] Keymaps work as expected
- [ ] LSP attaches correctly (`:LspInfo`)
- [ ] Plugins load appropriately (`:Lazy`)
- [ ] No performance regression (`:Lazy profile`)
- [ ] Formatted with StyLua (`stylua .`)

### Backup External Dependencies

**Mason-installed tools**:
- Location: `~/.local/share/nvim/mason/`
- Not in version control (too large)
- Reproducible: `:Mason` shows installed tools
- Reinstall after fresh install as needed

**External tools** (ripgrep, fd, etc.):
- Document in README.md or health checks
- Not part of config backup
- Install via system package manager

**System-specific configuration**:
- Some settings may be system-specific
- Document these in comments
- Use conditional logic: `if vim.fn.has 'win32' == 1 then`

---

## Useful Commands Reference

Quick reference for common operations when working in this configuration.

### Plugin Management
- `:Lazy` - Interactive plugin manager UI
- `:Lazy sync` - Install missing plugins and update all
- `:Lazy clean` - Remove unused plugins
- `:Lazy restore` - Restore plugins from lockfile (exact versions)
- `:Lazy profile` - Analyze startup time and plugin loading
- `:Lazy log` - View plugin installation logs
- `:Lazy update` - Update all plugins to latest versions

### LSP and Tools
- `:Mason` - Install LSP servers, formatters, linters
- `:LspInfo` - View attached LSP clients and their status
- `:LspRestart` - Restart all LSP servers in current buffer
- `:LspLog` - View LSP client logs
- `:ConformInfo` - View available formatters (if using conform.nvim)

### Fuzzy Finding (Telescope)
- `:Telescope` - Main Telescope menu
- `:Telescope keymaps` - Search all keymaps (find conflicts)
- `:Telescope diagnostics` - Browse all errors/warnings
- `:Telescope help_tags` - Search Neovim help documentation
- `:Telescope find_files` - Find files (alternative to `<leader>sf`)
- `:Telescope live_grep` - Search in files (alternative to `<leader>sg`)
- `:Telescope buffers` - Switch between open buffers

### Diagnostics
- `:checkhealth` - Comprehensive health check
- `:checkhealth kickstart` - Config-specific health checks
- `:checkhealth lazy` - Plugin manager health check
- `:checkhealth mason` - Tool installer health check
- `:checkhealth vim.lsp` - LSP client health check
- `:messages` - View all Neovim messages and errors

### File Explorer (if neo-tree enabled)
- `\` - Toggle Neo-tree file explorer (see `lua/kickstart/plugins/neo-tree.lua:13`)

### Help System
- `:help kickstart` - This config's built-in help documentation
- `:help vim.opt` - Help for options configuration
- `:help lazy.nvim` - Plugin manager documentation
- `:help lua-guide` - Lua in Neovim guide
- `:help` - Main help menu

### Reload and Source
- `:source %` - Reload current file (useful when editing config)
- `:luafile %` - Execute current Lua file
- `:Lazy reload <plugin>` - Reload specific plugin

---

## Final Notes

This configuration is designed to be a **learning tool**, not a complete IDE. Every choice is documented so you understand how Neovim works.

**When in doubt**:
1. Read the inline comments in relevant files
2. Check `:help` documentation
3. Run `:checkhealth` to diagnose issues
4. Ask questions with specific file references

**Contributing changes**:
- Follow existing patterns
- Maintain educational tone
- Document your reasoning
- Test thoroughly
- Format with StyLua

**Remember**: This config prioritizes understanding over features. If you're modifying it, help the next person understand why.

---

*For user-facing documentation, see `README.md`.*
*For Neovim help, run `:help kickstart`.*

<!-- vim: set tw=120: -->
