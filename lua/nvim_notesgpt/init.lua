local telescope = require('telescope.builtin')
local util = require('nvim_notesgpt.utils')

local nvim_notesgpt = {}

function nvim_notesgpt.create_new_note()
   local notesgpt_path = vim.fn.expand('~') .. '/notesGPT'

   local title = vim.fn.input('Enter note title: ')
   local note_path = notesgpt_path .. '/' .. title .. '.txt'

   if vim.fn.filereadable(note_path) == 0 then
      util.create_file(note_path)
   end

   vim.cmd('edit ' .. note_path)
   vim.cmd('normal G')
   vim.cmd('normal A')
   vim.cmd('normal o')
   vim.cmd('startinsert')
end

function nvim_notesgpt.search_notes()
   require('telescope.builtin').live_grep({
      prompt_title = '< Search Notes >',
      cwd = vim.fn.expand('~') .. '/notesGPT',
   })
end

function nvim_notesgpt.find_note()
   telescope.find_files({
      prompt_title = '< Find Note >',
      cwd = vim.fn.expand('~') .. '/notesGPT',
   })
end

function nvim_notesgpt.chat_note()
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

return nvim_notesgpt
