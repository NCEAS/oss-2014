# Vim, the editor

<!-- pandoc -i --self-contained -t s5 -s vim.md -o vim.html -->

![](images/Vim-editor_logo.png "http://images.wikia.com/vim/images/6/68/Vim-editor_logo.png")

# Other text editors

## Your typical editor works like this...

* When you type almost any key, the corresponding character (letter,
  number, symbol, or whitespace) appears at the cursor
* Certain special keys do special operations (control, alt, command,
  super)
* For a GUI app, you can/must click menus for other functionality


# Vim is different

## Vim has _modes_

Normal
 ~  for almost everything except typing!
Insert
 ~  for typing
Visual
 ~  for highlighting a region to operate on 
 ~  (and others you don't need to know about)

# The keyboard is your friend

![](images/vi-vim-cheat-sheet.gif
    "http://www.viemu.com/vi-vim-cheat-sheet.gif")

# For the impatient

- Start vim in terminal: `$ vi test.txt`
- Press `i` to enter insert mode
- Type to your heart's content
- When you're done, hit `Esc` to leave insert mode
- Then type `:w` to save your document
- Then type `:q` to quit
    - if you have unsaved changes, vim will complain
    - to save, see previous, or do `:wq` in one step
    - to discard changes and quit, do `:q!`

# Normal mode

### Now that you've seen that you _can_ actually type in vim, let's learn about the magic of Normal mode!

# Moving around ("motions")

**Stepping**

- by line: up `k`, down `j`
- by character: forward `l`, backward `h`
- by word: forward `w`, backward `b`
- by sentence: forward `)`, backward `(`
- by paragraph: forward `}`, backward `{`

# Moving around ("motions")

**Jumping**

- to start/end of line: `0/$`
- to start/end of file: `gg/G`
- to a character on current line: `f/F{char}`
- to identical word: `*/#`
- to line number: `:{#}` or `{#}G`
- to top, middle, or bottom of screen: `{HML}`

# Insert

- starting right where you are: `i`
- starting at the next character -- `a`
- starting at the end of the current line -- `A`
- starting at the beginning of the line -- `I`
- starting on the next line -- `o`
- starting on the previous line -- `O`
- enter 'replace mode' right where you are -- `R`
- replace current character with one other character -- `r{char}`
- delete current character, then enter insert mode -- `s`
- delete current line, then enter insert mode -- `S`

# Delete (really, this is "cut")

- delete character under cursor: `x`
- delete character before cursor: `X`
- delete to end of line: `D`
- delete entire line: `dd`
- delete # lines: `d#d`
- delete over some motion: `d{motion}`
- use backspace in insert mode (like every other editor)

# Copy and paste

- copy ("yank") -- `y{motion}`
- paste after cursor -- `p`
- paste before cursor -- `P`

# Search and replace

- we already saw some of this with jumping
- search for arbitrary expression -- `/{expression}`
- search and replace
    - `:s/foo/bar/`
    - `:s/foo/bar/g`
    - `:%s/foo/bar/g`

# Do-overs!

- undo change: `u`
- repeat last change: `.`
- redo last undone change: `Ctrl-r`

# Extras

- toggle case -- ~

# Saving and quitting

- save and quit: `ZZ` (or `:wq)`
- save and keep editing: `:w`
- quit without saving: `:q`
- *really* quit without saving: `:q!`

# Tabs

- open another file in new tab: `:tabe <file>`
- change tabs: forward `gt`, backward `gT`

# Basic editing

![](images/vi-vim-tutorial-1.gif
"http://www.viemu.com/a_vi_vim_graphical_cheat_sheet_tutorial.html")


# Operators and repetition

![](images/vi-vim-tutorial-2.gif
"http://www.viemu.com/a_vi_vim_graphical_cheat_sheet_tutorial.html")

# Yank & paste

![](images/vi-vim-tutorial-3.gif
"http://www.viemu.com/a_vi_vim_graphical_cheat_sheet_tutorial.html")

# Searching

![](images/vi-vim-tutorial-4.gif
"http://www.viemu.com/a_vi_vim_graphical_cheat_sheet_tutorial.html")

# Marks & macros

![](images/vi-vim-tutorial-5.gif
"http://www.viemu.com/a_vi_vim_graphical_cheat_sheet_tutorial.html")

# Various motions

![](images/vi-vim-tutorial-6.gif
"http://www.viemu.com/a_vi_vim_graphical_cheat_sheet_tutorial.html")

# Various commands

![](images/vi-vim-tutorial-7.gif
"http://www.viemu.com/a_vi_vim_graphical_cheat_sheet_tutorial.html")

# Places to learn

> * The [pictorial cheatsheets](
  http://www.viemu.com/a_vi_vim_graphical_cheat_sheet_tutorial.html)
  used in this slide
    - [Color PDF of all 8 diagrams](
      http://www.glump.net/_media/howto/vi-vim-cheat-sheet-and-tutorial.pdf)
* A nice [introduction with some clear prose](
    http://jmcpherson.org/editing.html)
* A popular portal to [the rest of the vim universe](
      http://thomer.com/vi/vi.html)
* A bit heavy-handed for my taste, but if you really like learning by
      [watching over someone's shoulder](
      http://www.linuxconfig.org/Vim_Tutorial)...
* Lastly, if you just want to learn [how to start *and* quit vim all in
  the first page of tips]( http://www.jerrywang.net/vi/)

