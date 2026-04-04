local g = vim.g
local opt = vim.opt

g.loaded_netrw=1
g.loaded_netrwPlugin=1

opt.clipboard = "unnamedplus"
opt.number = true
opt.relativenumber = true
opt.tabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.softtabstop = 4

-- Leader keys
g.mapleader = " "
g.maplocalleader = " "
vim.opt.termguicolors = true
