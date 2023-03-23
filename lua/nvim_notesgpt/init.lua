local telescope = require('telescope.builtin')
local ts_utils = require('nvim-treesitter.ts_utils')
local util = require('nvim_notesgpt.utils')

local function create_new_note()
   util.create_notesgpt_dir()
   local new_note_path = vim.fn.expand('~') .. '/notesGPT/' .. util.generate_unique_filename()
   vim.cmd('edit ' .. new_note_path)
end

local function find_note()
   telescope.find_files({
      prompt_title = '< Find Note >',
      cwd = vim.fn.expand('~') .. '/notesGPT',
   })
end

local function chat_note()
   local concatenated_notes = util.concatenate_notes()

   -- Send concatenated_notes to GPT API and receive response
   -- local gpt_response = send_to_gpt_api(concatenated_notes)

   -- For now, we will use a placeholder response
   local gpt_response = "This is a placeholder response from GPT."

   -- Open GPT response in a new buffer
   vim.api.nvim_command('new')
   vim.api.nvim_buf_set_lines(0, 0, -1, false, vim.split(gpt_response, '\n'))
   vim.api.nvim_buf_set_option(0, 'buftype', 'nofile')
   vim.api.nvim_buf_set_option(0, 'bufhidden', 'hide')
   vim.api.nvim_buf_set_option(0, 'swapfile', false)
end

return {
   create_new_note = create_new_note,
   find_note = find_note,
   chat_note = chat_note
}
