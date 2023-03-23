-- utils.lua

local util = {}

function util.create_notesgpt_dir()
    local notesgpt_path = vim.fn.expand('~') .. '/notesGPT'
    if vim.fn.isdirectory(notesgpt_path) == 0 then
        vim.fn.mkdir(notesgpt_path)
    end
end

function util.generate_unique_filename()
    local timestamp = os.date('%Y%m%d%H%M%S')
    return 'note_' .. timestamp .. '.txt'
end

function util.concatenate_notes()
    local notesgpt_path = vim.fn.expand('~') .. '/notesGPT'
    local files = vim.fn.globpath(notesgpt_path, '*.txt', 0, 1)
    local concatenated_notes = ""

    for _, file in ipairs(files) do
        local content = vim.fn.readfile(file)
        concatenated_notes = concatenated_notes .. table.concat(content, '\n') .. '\n'
    end

    return concatenated_notes
end

return util
