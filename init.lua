-----------------------------------------------------
--             NEOVIM MAIN SETTINGS                --
-----------------------------------------------------
_G.vim = vim
local set = vim.opt

set.number = true
set.relativenumber = true
set.clipboard = "unnamedplus"
set.shiftwidth = 4
set.tabstop = 4
set.swapfile = false
set.wrap = true
set.foldmethod = "manual"
set.mouse = "a"
set.splitbelow = true
set.splitright = true
set.termguicolors = true
set.linebreak = true
set.display:append("lastline")
set.spell = false
set.spelllang = { "en_us", "pt_br" }
set.spellfile = {
	"~/.config/nvim/spell/en.utf-8.add",
	"~/.config/nvim/spell/pt.utf-8.add",
}

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
			{ out,                            "WarningMsg" },
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
	change_detection = { enabled = false },
})

-----------------------------------------------------
--                 COLORSCHEME                     --
-----------------------------------------------------
vim.cmd([[ colorscheme onedark ]])

-----------------------------------------------------
--                   KEYMAPS                       --
-----------------------------------------------------
----[[
--Defines a key mapping with noremap and silent options.
--@param vim_mode string: The mode in which the mapping applies (e.g., 'n' for normal mode).
--@param key string: The key combination for the mapping.
--@param command string or function: The command or function to execute.
--]]
--_G.kmap = function(vim_mode, key, command)
--	local keymap = vim.keymap.set
--	local options = { noremap = true, silent = true }

--	keymap(vim_mode, key, command, options)
--end

-- Define a key mapping with noremap and silent options
-- @param vim_mode string: The mode in which the mapping applies (e.g., 'n' for normal mode)
-- @param key string: The key combination for the mapping
-- @param command string or function: The command or function to execute
-- @param description string: A description of the mapping for documentation
_G.kmap = function(vim_mode, key, command, description)
	local keymap = vim.keymap.set
	local options = { noremap = true, silent = true, desc = description }

	keymap(vim_mode, key, command, options)
end

-- save buffer
kmap("n", "<leader>w", ":w<CR>", "Save buffer.\n\n")

-- close buffer
kmap("n", "<leader>q", ":bd<CR>", "Close current buffer.\n\n")

-- change next buffer
kmap("n", "<leader>.", ":bn<CR>")

-- change previous buffer
kmap("n", "<leader>,", ":bp<CR>")

-- change previous buffer
kmap("n", "<C-'>", ":sp | term<CR>i")

-- spell suggestions
kmap("n", "<leader>s", "z=")

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
kmap("n", "<C-/>", "v<Plug>Commentary")
kmap("v", "<C-/>", "<Plug>Commentary")

-- PLUGIN: "nvim-neo-tree/neo-tree.nvim"
-- toggle neotree
kmap("n", "<leader>e", ":Neotree toggle<CR>")

-- "folke/zen-mode.nvim"
kmap("n", "<C-z>", ":ZenMode<CR>", "Toggle to zen mode.\n\n")

-- "nvim-telescope/telescope.nvim"
kmap("n", "<leader>ff", ":Telescope find_files<CR>", "Find files in working directory.\n\n")
kmap("n", "<leader>fg", ":Telescope live_grep<CR>", "Fuzzy finder in working directory.\n\n")
kmap("n", "<leader>fo", ":Telescope oldfiles<CR>", "Reopen recent files.\n\n")

-- "neovim/nvim-lspconfig"
kmap("n", "<Leader>f", "<Cmd>lua vim.lsp.buf.format()<CR>", "Formar current buffer.\n\n")
kmap("n", "<C-Space>", "<Cmd>lua vim.lsp.buf.hover()<CR>", "Open documentation.\n\n")

-----------------------------------------------------
--                REMOTE NEOVIM                    --
-----------------------------------------------------
if vim.fn.has("nvim") == 1 then
	vim.env.NVIM_LISTEN_ADDRESS = "/tmp/nvim"
end
