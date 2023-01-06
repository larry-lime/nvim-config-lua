--     __ __
--    / //_/__  __  ______ ___  ____ _____  _____
--   / ,< / _ \/ / / / __ `__ \/ __ `/ __ \/ ___/
--  / /| /  __/ /_/ / / / / / / /_/ / /_/ (__  )
-- /_/ |_\___/\__, /_/ /_/ /_/\__,_/ .___/____/
--           /____/               /_/

M = {}
vim.api.nvim_exec(
  [[
if has('wsl')
    let g:clipboard = {
      \   'name': 'wslclipboard',
      \   'copy': {
      \      '+': '/mnt/c/Users/larry/scoop/apps/neovim/0.6.1/bin/win32yank.exe -i --crlf',
      \    },
      \   'paste': {
      \      '+': '/mnt/c/Users/larry/scoop/apps/neovim/0.6.1/bin/win32yank.exe -i --crlf',
      \   },
      \   'cache_enabled': 1,
      \ }
endif

let g:focusModeNum = 0
function FocusUpNumToggle()
    if (g:focusModeNum == 0)
        let g:focusModeNum = 1
        set showtabline=0 | set winbar=
        set showtabline=0
    else
        let g:focusModeNum = 0
        set showtabline=3 | set winbar=%=%m%t
        set showtabline=3
    endif
endfunction

let g:orgSpaceState = 0
function OrgSpace(opt)
    if (g:orgSpaceState == 0)
        let g:orgSpaceState = 1
        NeorgStart silent=true
    endif
    silent! execute a:opt
endfunction

" Find a way to jump back to OG after a new one is closed
let g:focusMode = 0
function FocusUpToggle()
    if (g:focusMode == 0)
        tabnew %
        let g:focusMode = 1
        set laststatus=0 | set showtabline=0
        set winbar=
        lua vim.o.ch = 0
        set wrap | set nornu | set nonu
        set linebreak | set breakindent
        map k gk
        map j gj
        unmap )
        unmap (
    else
        q
        let g:focusMode = 0
        set laststatus=3 | set showtabline=3
        set nowrap | set rnu | set nu
        set winbar=%=%m%t
        lua vim.o.ch = 1
        set nolinebreak | set nobreakindent
        unmap k
        unmap j
        map ) g_
        map ( ^
    endif
endfunction
]] , true)

-- KEYBOARD SHORTCUTS --
local opts = { noremap = true, silent = true }
local nopts = { noremap = true, silent = false }
local keymap = vim.api.nvim_set_keymap
local jump_opt = { noremap = false, silent = true }

--Set Leader Key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Packer Keymaps
keymap("n", "<leader>I", ":so | PackerInstall<CR>", opts)
keymap("n", "<leader>U", ":so | PackerUpdate<CR>", opts)
keymap("n", "<leader>C", ":so | PackerClean<CR>", opts)

-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- Resize Windows
keymap("n", "<C-Up>", ":resize +2<CR>", opts)
keymap("n", "<C-Down>", ":resize -2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- Copy paste
keymap("v", "<C-C>", '"+y', opts)
keymap("n", "<C-C>", '"+yiw', opts)

-- Select All
keymap("n", "<leader>A", "GVgg", opts)

-- Reload File
keymap("n", "<leader>R", ":e!<CR>", opts)

-- Buffers
keymap("n", "<leader>Q", ":qa!<CR>", opts)
keymap("n", "<leader>qq", ":qa!<CR>", opts)
keymap("n", "<C-s>", "<C-^>", opts)
keymap("n", "]b", ":bnext<CR>", opts)
keymap("n", "[b", ":bprevious<CR>", opts)
keymap("n", "<C-x>", ":bd!<CR>", opts)
keymap("n", "<leader>oa", ":%bd! | e# |bd#<CR>", opts)
keymap("n", "<leader>x", ":q<CR>", opts)

-- Tabs
keymap("n", "<C-t>", ":tabnew<CR>", opts)
keymap("n", "<C-w>", ":tabclose<CR>", opts)

-- Custom Focus Modes
keymap("n", "<leader>Z", "<cmd>call FocusUpToggle()<CR>", opts)
-- keymap("n", "<leader>H", "<cmd>call FocusUpNumToggle()<CR>", opts)

-- Backspace
keymap("i", "<M-BS>", "<C-W>", opts)

-- Line Navigation
keymap("i", "<M-Enter>", "<Esc>o", opts)
keymap("i", "<M-l>", "<Esc>A", opts)
keymap("i", "<M-h>", "<Esc>I", opts)

-- Splits
keymap("n", "<leader>vs", ":vsplit<CR>", opts)
keymap("n", "<leader>sp", ":split<CR>", opts)

-- Surround Quotes
keymap("n", "<M-v>", "g_<C-v>^", opts)
keymap("n", [[<leader>']], [[ciw'<C-R>"'<Esc>]], opts)
keymap("n", [[<leader>"]], [[ciw"<C-R>""<Esc>]], opts)
keymap("n", [[<leader>(]], [[ciw(<C-R>")<Esc>F(]], opts)
keymap("n", [[<leader>[]], [[ciw[<C-R>"]<Esc>F[]], opts)
keymap("n", [[<leader>{]], [[ciw{<C-R>"}<Esc>]], opts)
keymap("n", [[<leader>`]], [[ciw`<C-R>"`<Esc>]], opts)

keymap("v", [[<leader>']], [[c'<C-R>"'<Esc>]], opts)
keymap("v", [[<leader>"]], [[c"<C-R>""<Esc>]], opts)
keymap("v", [[<leader>(]], [[c(<C-R>")<Esc>F(]], opts)
keymap("v", [[<leader>[]], [[c[<C-R>"]<Esc>F[]], opts)
keymap("v", [[<leader>{]], [[c{<C-R>"}<Esc>]], opts)
keymap("v", [[<leader>`]], [[c`<C-R>"`<Esc>]], opts)

-- Line Navigation
keymap("n", ")", "g_", opts)
keymap("n", "(", "^", opts)
keymap("v", ")", "g_", opts)
keymap("v", "(", "^", opts)

-- Renaming words
keymap("n", "<leader>rn", "*Ncgn", opts)
keymap("n", "<leader>ra", 'yiw:%s/<C-r>"/', nopts)

-- Apple Specific Keymaps
keymap("n", "<leader>of", ":silent !open . -a finder<CR>", opts)
keymap("n", "<leader>op", ":silent !open %<CR>", opts)
-- keymap("n", "<leader>dw", ":silent !open ~/Downloads/ -a finder<CR>", opts)

-- Terminal
keymap("t", "<C-\\>", "<C-\\><C-N>", opts)
keymap("t", "<C-j>", "<C-\\><C-N><C-w>j", opts)
keymap("t", "<C-k>", "<C-\\><C-N><C-w>k", opts)
keymap("t", "<C-l>", "<C-\\><C-N><C-w>l", opts)
keymap("t", "<C-h>", "<C-\\><C-N><C-w>h", opts)

-- Fugitive
keymap("n", "<leader>gaa", ":G add ", nopts)
keymap("n", "<leader>gpp", ":G push origin ", nopts)
keymap("n", "<leader>ga%", ":G add % | echo 'Git Add Current File'<CR>", opts)
keymap("n", "<leader>ga.", ":G add . | echo 'Git Add All Files'<CR>", opts)
keymap("n", "<leader>gr%", ":G reset % | echo 'Git Reset Current File'<CR>", opts)
keymap("n", "<leader>gr.", ":G reset . | echo 'Git Reset All Files'<CR>", opts)
keymap("n", "<leader>gc", ":G commit | startinsert<Cr>", opts)
keymap("n", "<leader>gl", ":G log<CR>", opts)
keymap("n", "<leader>gb", ":G branch | resize -20<CR>", opts)
keymap("n", "<leader>gs", ":G status<CR>", opts)

-- Move Nvim
keymap('n', '<A-j>', ":MoveLine(1)<CR>", opts)
keymap('n', '<A-k>', ":MoveLine(-1)<CR>", opts)
keymap('v', '<A-j>', ":MoveBlock(1)<CR>", opts)
keymap('v', '<A-k>', ":MoveBlock(-1)<CR>", opts)
keymap('n', '<A-l>', ":MoveHChar(1)<CR>", opts)
keymap('n', '<A-h>', ":MoveHChar(-1)<CR>", opts)
keymap('v', '<A-l>', ":MoveHBlock(1)<CR>", opts)
keymap('v', '<A-h>', ":MoveHBlock(-1)<CR>", opts)

-- Skip snippet part
keymap('s', '<C-n>', "<BS>i<A-n>", jump_opt)

-- Markdown Preview
keymap('n', '<leader>M', ":MarkdownPreviewToggle<CR>", opts)

M.show_documentation = function()
  local filetype = vim.bo.filetype
  if vim.tbl_contains({ "vim", "help" }, filetype) then
    vim.cmd("h " .. vim.fn.expand "<cword>")
  elseif vim.tbl_contains({ "man" }, filetype) then
    vim.cmd("Man " .. vim.fn.expand "<cword>")
  elseif vim.fn.expand "%:t" == "Cargo.toml" then
    require("crates").show_popup()
  else
    vim.lsp.buf.hover()
  end
end

vim.api.nvim_set_keymap("n", "K", "<cmd>silent lua require('user.keymaps').show_documentation()<CR>", opts)

return M
