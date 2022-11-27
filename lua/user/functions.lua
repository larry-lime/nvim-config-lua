M = {}

-- TODO: Figure out how to detect if a given terminal is open or now
local opts = { noremap = true, silent = true }
local keymap = vim.api.nvim_set_keymap
local execute = vim.api.nvim_exec

M.close_python = function() -- This is not working because of a weird autosave issue
  vim.g.ipython_open = false
  execute(":silent 1TermExec cmd='exit' go_back=0<CR>", true)
  keymap('n', '<leader>p1', ":lua require'user.functions'.run_file()<CR>", opts)
end

vim.g.ipython_open = false

M.open_python = function(func_name)
  vim.g.ipython_open = true
  if func_name == Ipython_spawn_h then
    keymap("n", "<leader>p1", ":1TermExec cmd='run %' go_back=0<CR>", opts) -- Remamps <leader>p1 to run the file in the runnig ipython terminal
  end
  if func_name == Ipython_spawn_v then
    keymap("n", "<leader>p2", ":2TermExec cmd='run %' go_back=0<CR>", opts) -- Remamps <leader>p1 to run the file in the runnig ipython terminal
  end
  func_name()
end

-- M.toggle_ipython = function() -- Needed so the cursor doesn't jump

-- Run File
-- FIXME: Not working when terminal is opened first and then p1/p2 is ran
M.run_file = function(arg) -- TODO have this take arguments
  local filetype = vim.bo.filetype
  if filetype == 'python' then
    if vim.g.ipython_open == false then
      if arg == 1 then
        M.open_python(Ipython_spawn_h) -- Starts a new python terminal
        execute(":silent 1TermExec cmd='run %' go_back=0<CR>", true) -- Runs the file
        keymap("n", "<leader>p1", ":1TermExec cmd='run %' go_back=0<CR>", opts) -- Remamps <leader>p1 to run the file in the runnig ipython terminal
      end
      if arg == 2 then
        M.open_python(Ipython_spawn_v) -- Starts a new python terminal
        execute(":silent 2TermExec cmd='run %' go_back=0<CR>", true) -- Runs the file
        keymap("n", "<leader>p2", ":2TermExec cmd='run %' go_back=0<CR>", opts) -- Remamps <leader>p1 to run the file in the runnig ipython terminal
      end
      vim.g.ipython_open = true
    end
  end
end

return M
