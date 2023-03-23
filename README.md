# nvim-notesgpt

Create and reference notes you create with the power of AI.

A Neovim plugin that helps you manage and search your notes, and interact with them using GPT.

## Features

- Create new notes with `<Space>NN`
- Search through note filenames with `<Space>FN`
- Send your notes to GPT for insights with `<Space>CN`

## Installation

### Using Packer

```lua
use {'mikeprograms/nvim-notesgpt'}
```

## Dependencies

Make sure you have the following plugins installed:

telescope.nvim
nvim-treesitter

## Usage

Use the defined hotkeys to create, search, and analyze your notes:

```
<Space>NN: Create a new note
<Space>FN: Search for a note
<Space>CN: Send your notes to GPT for insights
```

## Configuration

You can change the default hotkeys by adding the following to your init.lua or init.vim file, modifying the key sequences as desired:

```lua
vim.api.nvim_set_keymap('n', '<Space>NN', ':lua require("nvim_notesgpt").create_new_note()<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<Space>FN', ':lua require("nvim_notesgpt").find_note()<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<Space>CN', ':lua require("nvim_notesgpt").chat_note()<CR>', {noremap = true, silent = true})
```

## Contributing

Pull requests and issues are welcome!
