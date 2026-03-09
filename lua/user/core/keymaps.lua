local opts = { noremap = true, silent = true } -- noremap = no recursive map 

local term_opts = { silent = true }

-- Shorten function name 
local keymap = vim.api.nvim_set_keymap

-- Remap space as leader key 
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Modes 
--      normal_mode = "n"
--      insert_mode = "i"
--      visual_mode = "v"
--      term_mode = "t"
--      command_mode = "c"


-- Normal --
-- Better window navigation 
keymap("n", "<C-h>", "<C-w>h", opts) -- Ctrl + h to move left a split window
keymap("n", "<C-j>", "<C-w>j", opts) -- Ctrl + j to move down a split window
keymap("n", "<C-k>", "<C-w>k", opts) -- Ctrl + k to move up a split window
keymap("n", "<C-l>", "<C-w>l", opts) -- Ctrl + l to move right a split window

-- <leader>e is mapped to NvimTreeToggle below

-- Resizing Horizontally Split Windows ONLY!!
keymap("n", "<C-Up>", ":resize +2<CR>", opts) -- Ctrl + Up Arrow to resize window
keymap("n", "<C-Down>", ":resize -2<CR>", opts) -- Ctrl + Down Arrow to resize window

-- Resizing Vertically Split Windows ONLY!!
keymap("n", "<C-_>", ":vertical resize -2<CR>", opts) -- Ctrl + - to resize window
keymap("n", "<C-=>", ":vertical resize +2<CR>", opts) -- Ctrl + = to resize window

-- Navigate buffers (buffers is like tabs within a window)
keymap("n", "<S-l>", ":bnext<CR>", opts) -- Shift + l to move to next tab/buffer
keymap("n", "<S-h>", ":bprevious<CR>", opts) -- Shift + h to move to previous tab/buffer

-- Insert --
-- Press 'jk' really fast to exit insert mode 
keymap("i", "jk", "<ESC>", opts)

-- Visual --
-- Stay in indent mode 
keymap("v", "<", "<gv", opts) -- < to move highlighted indentation to the right
keymap("v", ">", ">gv", opts) -- > to move highlighted indentation to the left

-- Move text up and down
keymap("v", "<A-j>", ":m .+1<CR>==", opts) -- Alt + j to move highlighted text down
keymap("v", "<A-k>", ":m .-2<CR>==", opts) -- Alt + k to move highlighted text up
keymap("v", "p", '"_dP', opts) -- maintain orginal yank/copy text after a paste

-- Visual Block --
-- Move text up and down
keymap("x", "J", ":move '>+1<CR>gv-gv", opts) -- Capital J to move highlighted text down
keymap("x", "K", ":move '<-2<CR>gv-gv", opts) -- Capital K to move highlighted text up
keymap("x", "<A-j>", ":move '>+1<CR>gv-gv", opts) -- Alt + j to move highlighted text down
keymap("x", "<A-k>", ":move '<-2<CR>gv-gv", opts) -- Alt + k to move highlighted text up

-- Termianl --
-- Better terminal navigation 
keymap("t", "<C-h>", "<C-\\><C-N><C-w>h", term_opts) -- Ctrl + h to move left a termianl
keymap("t", "<C-j>", "<C-\\><C-N><C-w>j", term_opts) -- Ctrl + j to move down a termianl 
keymap("t", "<C-k>", "<C-\\><C-N><C-w>k", term_opts) -- Ctrl + k to move up a terminal 
keymap("t", "<C-l>", "<C-\\><C-N><C-w>l", term_opts) -- Ctrl + t to move right a terminal

-- Nvim-tree
keymap("n", "<leader>e", ":NvimTreeToggle<cr>", opts)

-- Telescope keymaps are defined in lua/user/plugins/telescope.lua
-- Format keymap is defined in lua/user/plugins/formatting.lua (<leader>mp)
