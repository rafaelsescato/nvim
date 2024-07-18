return {
	{
		-----------------------------------------------------
		--      GENERAL SUGGESTIONS AND AUTOCOMPLETE       --
		-----------------------------------------------------
		"hrsh7th/nvim-cmp",        -- https://github.com/hrsh7th/nvim-cmp
		dependencies = {
			"hrsh7th/cmp-buffer",  -- https://github.com/hrsh7th/cmp-buffer
			"hrsh7th/cmp-cmdline", -- https://github.com/hrsh7th/cmp-cmdline
			"hrsh7th/cmp-path",    -- https://github.com/hrsh7th/cmp-path
			"hrsh7th/cmp-nvim-lsp", -- https://github.com/hrsh7th/cmp_nvim_lsp
			"L3MON4D3/LuaSnip",    -- https://github.com/L3MON4D3/LuaSnip
			"saadparwaiz1/cmp_luasnip", -- https://github.com/saadparwaiz1/cmp_luasnip
			"rafamadriz/friendly-snippets", -- https://github.com/rafamadriz/friendly-snippets
		},
		config = function()
			local cmp = require("cmp")
			require("luasnip.loaders.from_vscode").lazy_load()

			local function border(hl_name)
				return {
					{ "╭", hl_name },
					{ "─", hl_name },
					{ "╮", hl_name },
					{ "│", hl_name },
					{ "╯", hl_name },
					{ "─", hl_name },
					{ "╰", hl_name },
					{ "│", hl_name },
				}
			end

			cmp.setup({
				snippet = {
					expand = function(args)
						require("luasnip").lsp_expand(args.body)
					end,
				},
				window = {
					completion = { border = border("CmpBorder") },
					documentation = { border = border("CmpDocBorder") },
				},
				mapping = {
					["<Tab>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
					["<S-Tab>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
					["<C-b>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),
					["<C-Space>"] = cmp.mapping.complete(),
					["<C-e>"] = cmp.mapping({
						i = cmp.mapping.abort(),
						c = cmp.mapping.close(),
					}),
					["<CR>"] = cmp.mapping.confirm({ select = true }),
				},
				sources = cmp.config.sources({
					{ name = "nvim_lsp" },
					{ name = "luasnip" },
					{ name = "buffer" },
					{ name = "path" },
				}),
			})

			-- Autocomplete specific files
			cmp.setup.filetype("gitcommit", {
				sources = cmp.config.sources({
					{ name = "cmp_git" },
					{ name = "buffer" },
				}),
			})

			-- Autocomplete command mode
			cmp.setup.cmdline("/", {
				mapping = cmp.mapping.preset.cmdline(),
				sources = { { name = "buffer" } },
			})

			cmp.setup.cmdline(":", {
				mapping = cmp.mapping.preset.cmdline(),
				sources = cmp.config.sources({
					{ name = "path" },
					{ name = "cmdline" },
				}),
			})
		end,
	},
	{
		-----------------------------------------------------
		--                    LSP                          --
		-----------------------------------------------------
		"neovim/nvim-lspconfig", -- https://github.com/neovim/nvim-lspconfig
		dependencies = {
			"hrsh7th/cmp-nvim-lsp", -- https://github.com/hrsh7th/cmp_nvim_lsp
			"williamboman/mason.nvim", -- https://github.com/williamboman/mason.nvim
		},
		config = function()
			local lspconfig = require("lspconfig")
			local capabilities = require("cmp_nvim_lsp").default_capabilities()
			require("mason").setup()

			-- Python
			lspconfig.pyright.setup(capabilities)
			-- GDScript
			lspconfig.gdscript.setup(capabilities)
			-- Lua
			lspconfig.lua_ls.setup(capabilities)

			-- floating diagnostics message
			vim.diagnostic.config({
				float = { source = "always", border = "rounded" },
				virtual_text = false,
				signs = true,
			})
			vim.cmd([[
				autocmd! CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false})
			]])
		end,
	},
	{
		-----------------------------------------------------
		--           FORMATTING AND DIAGNOSTICS            --
		-----------------------------------------------------
		"nvimtools/none-ls.nvim",   -- https://github.com/nvimtools/none-ls.nvim
		dependencies = {
			"nvimtools/none-ls-extras.nvim", -- https://github.com/nvimtools/none-ls-extras.nvim
		},
		config = function()
			local null_ls = require("null-ls")
			null_ls.setup({
				sources = {
					-- Lua
					null_ls.builtins.formatting.stylua,

					-- GDScript
					null_ls.builtins.formatting.gdformat,
					null_ls.builtins.diagnostics.gdlint,

					-- Python
					null_ls.builtins.formatting.isort,
					null_ls.builtins.formatting.black,
					require("null_ls.builtins.diagnostics.flake8"),

					-- JavaScript, TypeScript, JSX, CSS, SCSS, Less,
					-- JSON, HTML, Markdown, YAML, GraphQL, Vue.js (.vue files),
					-- React.js (.jsx, .tsx files), Angular (.component.ts, .service.ts files)
					null_ls.builtins.formatting.prettier,

					-- JavaScript (JS), TypeScript (TS), JSX, Vue.js (.vue files)
					-- React.js (.jsx, .tsx files)
					-- null_ls.builtins.diagnostics.eslint,
				},
			})
		end,
	},
	{
		-----------------------------------------------------
		--                SYNTAX HIGHLIGHTING              --
		-----------------------------------------------------
		"nvim-treesitter/nvim-treesitter", -- https://github.com/nvim-treesitter/nvim-treesitter
		run = ":TSUpdate",
		config = function()
			require("nvim-treesitter.configs").setup({
				auto_install = true,
				highlight = { enable = true },
				indent = { enable = true },
			})
		end,
	},
}
