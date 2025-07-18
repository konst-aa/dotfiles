local builtin = require("telescope.builtin")
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")

-- thank you chatgpt
-- local function open_selected_in_buffers(prompt_bufnr)
--   local picker = action_state.get_current_picker(prompt_bufnr)
--   local selections = picker:get_multi_selection()

--   -- If nothing was selected, fallback to current entry
--   if vim.tbl_isempty(selections) then
--     table.insert(selections, action_state.get_selected_entry())
--   end

--   actions.close(prompt_bufnr)

--   for _, entry in ipairs(selections) do
--     vim.cmd("edit " .. vim.fn.fnameescape(entry.path))
--   end
-- end

-- https://github.com/nvim-telescope/telescope.nvim/issues/814#issuecomment-1238510694
require("telescope").setup {
defaults = {
mappings = {
    i = {
      -- ["<S-CR>"] = function(prompt_bufnr) 
      --     actions.select_default(prompt_bufnr)
      --     builtin.resume()
      -- end,
      ["<C-q>"] = actions.send_selected_to_qflist,
      ["<C-Q>"] = actions.send_to_qflist,
    },
  },


}
}

-- keybinds
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
vim.keymap.set('n', '<leader>ft', builtin.treesitter, {})
vim.keymap.set('n', '<leader>fw', builtin.grep_string, {})
vim.keymap.set('n', '<leader>fr', builtin.current_buffer_fuzzy_find, {})
