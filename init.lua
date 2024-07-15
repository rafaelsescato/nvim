-----------------------------------------------------
--             NEOVIM MAIN SETTINGS                --
-----------------------------------------------------
_G.vim = vim
local set = vim.opt

set.number = true
set.relativenumber = true
set.completeopt = "noinsert,menuone,noselect"
set.shiftwidth = 4
set.clipboard = "unnamedplus"
set.tabstop = 4
set.expandtab = false
set.swapfile = false
set.wrap = true
set.foldmethod = "manual"
set.mouse = "a"
set.termguicolors = true
set.wildmenu = true
set.splitbelow = true
set.splitright = true
set.ttimeoutlen = 0
set.updatetime = 250
set.title = true
set.smarttab = true

-----------------------------------------------------
--                 LEADER KEY                      --
-----------------------------------------------------
vim.g.mapleader = " "

-----------------------------------------------------
--                PLUGIN MANAGER                   --
-----------------------------------------------------
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	spec = {
		{ import = "plugins" },
	},
	checker = {
		enabled = false,
		notify = false,
	},
})

-----------------------------------------------------
--                 COLORSCHEME                     --
-----------------------------------------------------
vim.cmd([[ colorscheme onedark ]])

-----------------------------------------------------
--                   KEYMAPS                       --
-----------------------------------------------------
--[[
Defines a key mapping with noremap and silent options.
@param vim_mode string: The mode in which the mapping applies (e.g., 'n' for normal mode).
@param key string: The key combination for the mapping.
@param command string or function: The command or function to execute.
]]
_G.kmap = function(vim_mode, key, command)
	local keymap = vim.keymap.set
	local options = { noremap = true, silent = true }

	keymap(vim_mode, key, command, options)
end

-- save buffer
kmap("n", "<leader>w", ":w<CR>")

-- close buffer
kmap("n", "<leader>q", ":bd<CR>")

-- change next buffer
kmap("n", "<leader>.", ":bn<CR>")

-- change previous buffer
kmap("n", "<leader>,", ":bp<CR>")

-- change previous buffer
kmap("n", "<C-'>", ":sp | term<CR>i")

-- change window in terminal mode
kmap("t", "<A-h>", "<C-\\><C-N><C-w>h")
kmap("t", "<A-j>", "<C-\\><C-N><C-w>j")
kmap("t", "<A-k>", "<C-\\><C-N><C-w>k")
kmap("t", "<A-l>", "<C-\\><C-N><C-w>l")

-- change window in insert mode
kmap("i", "<A-h>", "<C-\\><C-N><C-w>h")
kmap("i", "<A-j>", "<C-\\><C-N><C-w>j")
kmap("i", "<A-k>", "<C-\\><C-N><C-w>k")
kmap("i", "<A-l>", "<C-\\><C-N><C-w>l")

-- change window in normal mode
kmap("n", "<A-h>", "<C-w>h")
kmap("n", "<A-j>", "<C-w>j")
kmap("n", "<A-k>", "<C-w>k")
kmap("n", "<A-l>", "<C-w>l")

-- PLUGIN: "booperlv/nvim-gomove"
-- move selections
kmap("x", "<A-h>", "<Plug>GoVSMLeft")
kmap("x", "<A-j>", "<Plug>GoVSMDown")
kmap("x", "<A-k>", "<Plug>GoVSMUp")
kmap("x", "<A-l>", "<Plug>GoVSMRight")

-- PLUGIN: "tpope/vim-commentary"
-- toggle commentary in visual mode
kmap("v", "<C-/>", "<Plug>Commentary")

-- PLUGIN: "nvim-neo-tree/neo-tree.nvim"
-- toggle neotree
kmap("n", "<leader>e", ":Neotree toggle<CR>")

-- PLUGIN: "folke/zen-mode.nvim"
-- toggle zen mode
kmap("n", "<C-z>", ":ZenMode<CR>")

-- PLUGIN: "nvim-telescope/telescope.nvim"
local telescope = require("telescope.builtin")
-- file finder
kmap("n", "<leader>ff", telescope.find_files)
-- fuzzy finder
kmap("n", "<leader>fg", telescope.live_grep)
-- open recent files
kmap("n", "<leader>fo", telescope.oldfiles)

-- PLUGIN: "neovim/nvim-lspconfig"
-- format buffer
kmap("n", "<leader>f", vim.lsp.buf.format)
