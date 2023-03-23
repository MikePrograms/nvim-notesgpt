local telescope = require('telescope.builtin')
local ts_utils = require('nvim-treesitter.ts_utils')
local util = require('nvim_notesgpt.utils')

local function create_new_note()
   local notesgpt_path = vim.fn.expand('~') .. '/notesGPT'

   -- Custom entry maker for live_grep
   local entry_maker = function(entry)
      local filename = vim.fn.fnamemodify(entry.filename, ':t')
      return {
         valid = true,
         value = entry,
         ordinal = filename,
         display = filename,
      }
   end

   -- Custom attach callback for live_grep
   local on_attach = function(prompt_bufnr)
      local function create_or_open_note()
         local title = require('telescope.actions.state').get_current_line()
         local note_path = notesgpt_path .. '/' .. title .. '.txt'

         if vim.fn.filereadable(note_path) == 1 then
            vim.cmd('edit ' .. note_path)
         else
            util.create_file(note_path)
            vim.cmd('edit ' .. note_path)
         end

         vim.cmd('stopinsert')
         require('telescope.actions').close(prompt_bufnr)
      end

      -- Map <CR> to create or open the note
      require('telescope.actions.set').set_mapping("<CR>", create_or_open_note, { noremap = true, silent = true })
   end

   require('telescope.builtin').live_grep({
      prompt_title = '< New Note >',
      search_dirs = { notesgpt_path },
      entry_maker = entry_maker,
      attach_mappings = function(_, map)
         map('i', '<CR>', on_attach)
         return true
      end,
   })
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
