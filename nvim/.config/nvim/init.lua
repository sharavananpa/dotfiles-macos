-- Enable line numbers
vim.opt.number = true

-- Enable relative line numbers
vim.opt.relativenumber = true

-- Set indentation
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true

-- Enable mouse support
vim.opt.mouse = ""

-- Enable system clipboard
vim.opt.clipboard = "unnamedplus"

-- Search settings
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.incsearch = true
vim.opt.hlsearch = false

-- Use space as the leader key (for easier keybindings)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Better splits
vim.opt.splitright = true
vim.opt.splitbelow = true

local map = vim.api.nvim_set_keymap
local options = { noremap = true, silent = true }

-- Save with Ctrl + S
map("n", "<C-s>", ":w<CR>", options)

-- Quit with Ctrl + Q
map("n", "<C-q>", ":q<CR>", options)

-- Move between splits using Ctrl + hjkl
map("n", "<C-h>", "<C-w>h", options)
map("n", "<C-j>", "<C-w>j", options)
map("n", "<C-k>", "<C-w>k", options)
map("n", "<C-l>", "<C-w>l", options)

-- Clear search highlight with ESC twice
map("n", "<ESC><ESC>", ":nohlsearch<CR>", options)

