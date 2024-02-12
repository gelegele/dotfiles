# My Cheat Sheet

## VIM
### Normal Mode
- gf
  - Go to the file. 
- gt, gT
  - Go to the next/previous tab page.
- C-]
  - Jump to the definition of the word under the cursor.
- C-o C-i
  - Jump to the previous/next cursor position.
  - Control Out, Control In
- g; g,
  - Navigate through the changelist.
- C-] c-t
  - Move to the definition.
- %
  - Navigate between matching pairs.
- ]p
  - Paste and indent.
- @:
  - Execute the last Ex command.
- q:
  - Show Ex command history.
### Insert Mode
- C-u
  - Delete line text before the cursor position.
- C-w
  - Delete a word before the cursor position.
- C-h
  - Delete a charactor before the cursor position.
- C-r
  - Show register.
### Visual Mode
- o
  - Toggles the upper and lower ends of selection.
- u U
  - Lowercase / Uppercase the selection.

### Command Line Mode
- :r !pwd
  - Insert the output of the os command.
- :e ++enc=sjis
  - Reopen the file with SJIS.
- :3,5d
  - Delete lines 3 to 5.
- :%g/{pattern}/d
  - Delete all lines containing pattern.
- :%v/{pattern}/d
  - Delete all lines not containing pattern.

### Telescope
- C-/
  - Show which-key.
- C-c
  - Close

## TMUX
- C-Space + [
  - Enter Copy mode.
- C-Space + ]
  - Paste copied text.
- C-Space + s
  - Split pane horizontally.
- C-Space + v
  - Split pane vertially.

## Linux
- C-+, C--, C-0
  - Resize sreen.
- nvim --clean
  - Start nvim without config.
- curl -LO https://hoge.com/hoge.txt
  - Download a file as the name.
- showkey -a
  - Check key code.
