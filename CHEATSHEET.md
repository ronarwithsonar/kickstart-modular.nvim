# Neovim & Vim Cheatsheet for Beginners

A beginner-friendly reference guide for essential Vim motions, commands, and Neovim features.

> **Tip**: In Vim/Neovim, you're always in one of several "modes". Understanding modes is the key to mastering Vim!

---

## Modes

| Mode | How to Enter | Purpose |
|------|--------------|---------|
| **Normal** | `Esc` or `Ctrl+[` | Navigate, delete, copy, paste (default mode) |
| **Insert** | `i`, `a`, `o`, etc. | Type and edit text |
| **Visual** | `v`, `V`, `Ctrl+v` | Select text |
| **Command** | `:` | Run commands (save, quit, search/replace) |

**Golden Rule**: When in doubt, press `Esc` to return to Normal mode.

---

## Basic Navigation (Normal Mode)

### Character & Line Movement
| Key | Action |
|-----|--------|
| `h` | Move left |
| `j` | Move down |
| `k` | Move up |
| `l` | Move right |
| `0` | Jump to beginning of line |
| `^` | Jump to first non-blank character |
| `$` | Jump to end of line |

### Word Movement
| Key | Action |
|-----|--------|
| `w` | Jump to start of next word |
| `b` | Jump to start of previous word |
| `e` | Jump to end of current/next word |
| `W`, `B`, `E` | Same as above, but treats punctuation as part of word |

### Screen Movement
| Key | Action |
|-----|--------|
| `gg` | Go to first line of file |
| `G` | Go to last line of file |
| `{number}G` | Go to line number (e.g., `42G` goes to line 42) |
| `Ctrl+d` | Scroll down half page |
| `Ctrl+u` | Scroll up half page |
| `Ctrl+f` | Scroll down full page |
| `Ctrl+b` | Scroll up full page |
| `H` | Jump to top of screen |
| `M` | Jump to middle of screen |
| `L` | Jump to bottom of screen |

---

## Entering Insert Mode

| Key | Action |
|-----|--------|
| `i` | Insert before cursor |
| `I` | Insert at beginning of line |
| `a` | Append after cursor |
| `A` | Append at end of line |
| `o` | Open new line below and insert |
| `O` | Open new line above and insert |
| `s` | Substitute character (delete and insert) |
| `S` | Substitute entire line |

---

## Editing (Normal Mode)

### Delete (Cut)
| Key | Action |
|-----|--------|
| `x` | Delete character under cursor |
| `X` | Delete character before cursor |
| `dd` | Delete entire line |
| `D` | Delete from cursor to end of line |
| `dw` | Delete word |
| `d$` | Delete to end of line |
| `d0` | Delete to beginning of line |

### Copy (Yank) & Paste
| Key | Action |
|-----|--------|
| `yy` | Yank (copy) entire line |
| `yw` | Yank word |
| `y$` | Yank to end of line |
| `p` | Paste after cursor |
| `P` | Paste before cursor |

### Change (Delete + Insert)
| Key | Action |
|-----|--------|
| `cc` | Change entire line |
| `cw` | Change word |
| `c$` or `C` | Change to end of line |
| `ci"` | Change inside quotes |
| `ci(` | Change inside parentheses |
| `ciw` | Change inner word |

### Undo & Redo
| Key | Action |
|-----|--------|
| `u` | Undo |
| `Ctrl+r` | Redo |
| `.` | Repeat last change |

---

## The Power of Vim: Combining Motions

Vim commands follow a grammar: **[count][operator][motion]**

**Examples**:
- `3w` - Move 3 words forward
- `d2w` - Delete 2 words
- `y3j` - Yank current line and 3 lines below
- `c4l` - Change 4 characters
- `5dd` - Delete 5 lines
- `2p` - Paste 2 times

**Common Operators**:
- `d` - Delete
- `c` - Change (delete + insert mode)
- `y` - Yank (copy)
- `>` - Indent right
- `<` - Indent left

---

## Visual Mode (Selection)

| Key | Action |
|-----|--------|
| `v` | Start character-wise visual selection |
| `V` | Start line-wise visual selection |
| `Ctrl+v` | Start block (column) visual selection |
| `gv` | Reselect last visual selection |

**After selecting**, use operators:
- `d` - Delete selection
- `y` - Yank selection
- `c` - Change selection
- `>` - Indent selection
- `<` - Unindent selection
- `~` - Toggle case
- `u` - Lowercase
- `U` - Uppercase

---

## Search & Replace

### Search
| Key | Action |
|-----|--------|
| `/pattern` | Search forward for pattern |
| `?pattern` | Search backward for pattern |
| `n` | Jump to next match |
| `N` | Jump to previous match |
| `*` | Search forward for word under cursor |
| `#` | Search backward for word under cursor |

### Search & Replace (Command Mode)
```vim
:s/old/new/        " Replace first occurrence on current line
:s/old/new/g       " Replace all occurrences on current line
:%s/old/new/g      " Replace all occurrences in entire file
:%s/old/new/gc     " Replace all with confirmation
```

---

## File Operations (Command Mode)

| Command | Action |
|---------|--------|
| `:w` | Save (write) file |
| `:q` | Quit |
| `:wq` or `:x` | Save and quit |
| `:q!` | Quit without saving (force) |
| `:w filename` | Save as new filename |
| `:e filename` | Edit (open) file |
| `:e!` | Reload file, discarding changes |
| `:enew` | Create new empty buffer |

---

## Window & Buffer Management

### Windows (Splits)
| Key/Command | Action |
|-------------|--------|
| `:split` or `:sp` | Horizontal split |
| `:vsplit` or `:vs` | Vertical split |
| `Ctrl+w h/j/k/l` | Move between windows |
| `Ctrl+w w` | Cycle through windows |
| `Ctrl+w q` | Close current window |
| `Ctrl+w o` | Close all other windows |
| `Ctrl+w =` | Make all windows equal size |
| `Ctrl+w +/-` | Increase/decrease height |
| `Ctrl+w >/<` | Increase/decrease width |

### Buffers
| Command | Action |
|---------|--------|
| `:ls` or `:buffers` | List all buffers |
| `:b {number}` | Switch to buffer number |
| `:bnext` or `:bn` | Next buffer |
| `:bprev` or `:bp` | Previous buffer |
| `:bd` | Delete (close) current buffer |

### Tabs
| Command | Action |
|---------|--------|
| `:tabnew` | Create new tab |
| `:tabnext` or `gt` | Next tab |
| `:tabprev` or `gT` | Previous tab |
| `:tabclose` | Close current tab |

---

## Neovim-Specific Features

### Built-in Terminal
| Command | Action |
|---------|--------|
| `:terminal` | Open terminal in current window |
| `:split \| terminal` | Open terminal in horizontal split |
| `Ctrl+\ Ctrl+n` | Exit terminal mode (back to Normal) |

### LSP (Language Server Protocol)
| Command | Action |
|---------|--------|
| `:LspInfo` | Show attached LSP clients |
| `:LspRestart` | Restart LSP servers |
| `K` | Show hover documentation (if configured) |
| `gd` | Go to definition (if configured) |
| `gr` | Show references (if configured) |

### Health & Diagnostics
| Command | Action |
|---------|--------|
| `:checkhealth` | Run health checks |
| `:messages` | View message history |

---

## This Config's Keymaps (kickstart.nvim)

This configuration uses **Space** as the leader key (`<leader>`).

### Common Leader Keymaps
| Keymap | Action |
|--------|--------|
| `<leader>sf` | **S**earch **F**iles |
| `<leader>sg` | **S**earch by **G**rep |
| `<leader>sh` | **S**earch **H**elp |
| `<leader>sk` | **S**earch **K**eymaps |
| `<leader>sw` | **S**earch current **W**ord |
| `<leader>sd` | **S**earch **D**iagnostics |
| `<leader>sr` | **S**earch **R**esume |
| `<leader>s.` | Search recent files |
| `<leader>/` | Fuzzy search in current buffer |
| `<leader>q` | Open diagnostic quickfix list |
| `\` | Toggle file explorer (Neo-tree) |

### LSP Keymaps (when LSP is attached)
| Keymap | Action |
|--------|--------|
| `gd` | **G**oto **D**efinition |
| `gD` | **G**oto **D**eclaration |
| `gr` | **G**oto **R**eferences |
| `gI` | **G**oto **I**mplementation |
| `<leader>D` | Type **D**efinition |
| `<leader>ds` | **D**ocument **S**ymbols |
| `<leader>ws` | **W**orkspace **S**ymbols |
| `<leader>rn` | **R**e**n**ame |
| `<leader>ca` | **C**ode **A**ction |
| `K` | Hover documentation |

### Git Keymaps (gitsigns)
| Keymap | Action |
|--------|--------|
| `]c` | Next git change |
| `[c` | Previous git change |
| `<leader>hs` | **H**unk **S**tage |
| `<leader>hr` | **H**unk **R**eset |
| `<leader>hS` | Stage buffer |
| `<leader>hu` | **H**unk **U**ndo stage |
| `<leader>hp` | **H**unk **P**review |
| `<leader>hb` | **H**unk **B**lame line |
| `<leader>hd` | **H**unk **D**iff |

> **Tip**: Press `<leader>` (Space) and wait - which-key will show available keymaps!

---

## Quick Tips for Beginners

1. **Use `vimtutor`**: Run `vimtutor` in your terminal for an interactive tutorial
2. **Start simple**: Master `hjkl`, `i`, `Esc`, `:w`, `:q` before learning more
3. **Think in motions**: Vim is about combining actions with movements
4. **Use `.` (dot)**: It repeats your last change - incredibly powerful
5. **Don't memorize everything**: Learn what you need, when you need it
6. **Use `:help`**: Type `:help topic` to learn about anything

---

## Getting Help

| Command | Action |
|---------|--------|
| `:help` | Open help (`:q` to close) |
| `:help topic` | Help on specific topic |
| `:help :command` | Help on command-mode command |
| `:help 'option'` | Help on option (note the quotes) |
| `:Telescope help_tags` | Fuzzy search help (this config) |

---

## Vim Philosophy

> "Vim is not about typing faster; it's about **thinking** in text manipulation."

- **Avoid the mouse**: Everything can be done from the keyboard
- **Composability**: Small commands combine into powerful operations
- **Muscle memory**: Speed comes naturally with practice
- **Edit, don't type**: Most time is spent editing, not writing new text

---

*Practice makes permanent. Start with the basics and gradually expand your vocabulary!*

<!-- vim: set tw=100: -->
