-- 'User' Folder Contains Your Personal Configurations for NeoVim

-- Table w/ Options
local options = {
    number = true,							-- set numbered lines
    expandtab = true, 						-- conver tabs to spaces
    shiftwidth = 4, 						-- the number of spaces inserted for each indentation
    tabstop = 4, 							-- insert 2 spaces for a tab 
    mouse = "a",                            -- allow the mouse to be used in neovim
    backup = false,                         -- creates a backup file
    clipboard = "unnamedplus",              -- allows neovim to access the system clipboard
    cmdheight = 2,                          -- more space in the neovim command line for displaying messages
    conceallevel = 0,                       -- so that `` is visible in markdown files 
    fileencoding = "utf-8",                 -- the encoding written to a file 
    hlsearch = true,                        -- highlight all matches on previous search pattern 
    ignorecase = true,                      -- ignore case in search pattern
    showtabline = 2,                        -- always show tabs
    smartcase = true,                       -- smart case
    smartindent = true,                     -- make indenting smarter again 
    splitbelow = true,                      -- force all horizontal splits to go below current window 
    splitright = true,                      -- force all vertical splits to go to the right of current window
    swapfile = false,                       -- creates a swapfile 
    termguicolors = true,                   -- set term gui colors (most termianls support this)
    timeoutlen = 1000,                      -- time to wait for a mapped sequence to complete (in milliseconds)
    undofile = true,                        -- enables persistent undo
    updatetime = 300,                       -- faster completion (4000ms default)
    writebackup = false,                    -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be editied
    cursorline = true,                      -- highlight the current line 
    relativenumber = true,                 -- set relative numbered lines
    numberwidth = 4,                        -- set number column width (default 4)
    signcolumn = "yes",                     -- always show the sign column, otherwise it would shift the text eac time
    wrap = false,                           -- display lines as one long time 
    scrolloff = 8,                          -- minimal number of screen lines to keep above and below the cursor
    sidescrolloff = 8,                      -- minimal number of screen columns t keep to the left and to the right of the cursor
    guifont = "monospace:h17",              -- the font used in graphical neovim applications
    completeopt = { "menuone", "noselect"}, --  mostly for completion stuff
    pumheight = 10,                         -- pop up menu height 
    showmode = false,                        -- Show the mode we're in
    winborder = "rounded",
}

-- Loop Thru 'options' Table & Execute Each Option
for k, v in pairs(options) do
	vim.opt[k] = v
end
