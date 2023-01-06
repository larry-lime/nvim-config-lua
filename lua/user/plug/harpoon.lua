require("harpoon").setup {
  global_settings = {
    -- sets the marks upon calling `toggle` on the ui, instead of require `:w`.
    save_on_toggle = false,

    -- saves the harpoon file upon every change. disabling is unrecommended.
    save_on_change = true,

    -- sets harpoon to run the command immediately as it's passed to the terminal when calling `sendCommand`.
    enter_on_sendcmd = false,

    -- closes any tmux windows harpoon that harpoon creates when you close Neovim.
    tmux_autoclose_windows = false,

    -- filetypes that you want to prevent from adding to the harpoon list menu.
    excluded_filetypes = { "harpoon" },

    -- set marks specific to each git branch inside git repository
    mark_branch = false,
  }
}

local opts = { noremap = true, silent = true }
local keymap = vim.api.nvim_set_keymap

-- Harpoon
keymap("n", "<leader>=", ":lua require('harpoon.ui').toggle_quick_menu()<CR>", opts)
keymap("n", "<leader>a", ":echo 'File added to harpoon' |lua require('harpoon.mark').add_file()<CR>", opts)
keymap("n", "<leader>!", ":echo 'Nav File 1'| lua require('harpoon.ui').nav_file(1)<CR>", opts)
keymap("n", "<leader>@", ":echo 'Nav File 2'|lua require('harpoon.ui').nav_file(2)<CR>", opts)
keymap("n", "<leader>#", ":echo 'Nav File 3'|lua require('harpoon.ui').nav_file(3)<CR>", opts)
keymap("n", "<leader>$", ":echo 'Nav File 4'|lua require('harpoon.ui').nav_file(4)<CR>", opts)
keymap("n", "<leader>%", ":echo 'Nav File 5'|lua require('harpoon.ui').nav_file(5)<CR>", opts)
keymap("n", "<leader>^", ":echo 'Nav File 6'|lua require('harpoon.ui').nav_file(6)<CR>", opts)
