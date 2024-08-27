return {
	{
		-----------------------------------------------------
		--                  NEOVIM HOME                    --
		-----------------------------------------------------
		"goolord/alpha-nvim", -- https://github.com/goolord/alpha-nvim
		dependencies = {
			"nvim-tree/nvim-web-devicons", -- https://github.com/nvim-tree/nvim-web-devicons
			"nvim-lua/plenary.nvim", -- https://github.com/nvim-lua/plenary.nvim
		},
		config = function()
			local alpha = require("alpha")
			local dashboard = require("alpha.themes.dashboard")

			dashboard.section.header.val = {

				-- "      ████ ██████           █████     ███",
				-- "     ███████████             █████ ",
				-- "     █████████ ███████████████████ ███   ███████████",
				-- "    █████████  ███    █████████████ █████ ██████████████",
				-- "   █████████ ██████████ █████████ █████ █████ ████ █████",
				-- " ███████████ ███    ███ █████████ █████ █████ ████ █████",
				-- "██████  █████████████████████ ████ █████ █████ ████ ██████",

				-- " ",
				-- " ",
				-- " ",
				-- " ",
				-- " ",
				-- " ",
				-- "  ╱╲",
				-- " ╱╲ ╲",
				-- "╱╲ ╲ ╲",
				-- "▔▔▔▔▔▔",
				-- " ",

				-- " ",
				-- " ",
				-- " ",
				-- " ",
				-- " ",
				-- "      ",
				-- "     ██",
				-- "     ███",
				-- "    ███",
				-- "  ██ ███",
				-- "  ███ ███",
				-- " ███ ███",
				-- " ",

				-- " ",
				-- " ",
				-- " ",
				-- " ",
				-- " ",
				-- "      ",
				-- "     ██",
				-- "    ███",
				-- "   ███ ",
				-- "  ███ ██",
				-- " ███ ███",
				-- "███ ███ ",
				-- " ",

				-- " ",
				-- " ",
				-- " ",
				-- " ",
				-- " ",
				-- "                  ",
				-- "     ██          ██",
				-- "     ███        ███",
				-- "    ███      ███ ",
				-- "  ██ ███    ███ ██",
				-- "  ███ ███  ███ ███",
				-- " ███ ██████ ███ ",
				-- " ",

				-- "      █████",
				-- "     ███████",
				-- "    █████████",
				-- "    ██   ██",
				-- "     ██ ██",
				-- "   ███████████",
				-- "  ██   ██",
				-- " ██     ██",
				-- "███     ███",
				-- "█           █",
				-- " ██ ███ ██ ",
				-- " ███████████",
				-- "  ██       ██",

				"                      █████",
				"                     ███████",
				"                    █████████",
				"                    ██   ██",
				"                     ██ ██",
				"                 ███████████           ",
				"     ██         ██   ██         ██",
				"     ███       ██     ██       ███",
				"    ███     ███     ███     ███ ",
				"  ██ ███    █           █    ███ ██",
				"  ███ ███    ██ ███ ██    ███ ███",
				" ███ ███   ███████████   ███ ███ ",
				"                  ██       ██",
			}

			-- Set menu
			dashboard.section.buttons.val = {
				dashboard.button("e", "󰈔  NEW FILE", ":ene <BAR> startinsert <CR>"),
				dashboard.button("f", "󰱼  FIND FILE", ":Telescope find_files cwd=.<CR>"),
				dashboard.button("r", "󱋡  RECENT FILES", ":Telescope oldfiles<CR>"),
				dashboard.button("s", "󱁻  SETTINGS", ":cd $HOME/.config/nvim | :e $HOME/.config/nvim/init.lua<CR>"),
				dashboard.button("q", "󱠡  QUIT", ":qa<CR>"),
			}

			-- Get random mensage
			local fortune = require("alpha.fortune")
			dashboard.section.footer.val = fortune()

			-- Send config to alpha
			alpha.setup(dashboard.opts)

			-- Disable folding on alpha buffer
			vim.cmd([[
				autocmd FileType alpha setlocal nofoldenable
			]])
		end,
	},

	{
		-----------------------------------------------------
		--                 TREE EXPLORER                   --
		-----------------------------------------------------
		"nvim-neo-tree/neo-tree.nvim", -- https://github.com/nvim-neo-tree/neo-tree.nvim
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim", -- https://github.com/nvim-lua/plenary.nvim
			"nvim-tree/nvim-web-devicons", -- https://github.com/nvim-tree/nvim-web-devicons
			"MunifTanjim/nui.nvim", -- https://github.com/MunifTanjim/nui.nvim
		},
		config = function()
			require("neo-tree").setup({
				close_if_last_window = false,
				enable_diagnostics = true,
				enable_git_status = true,
				popup_border_style = "rounded",
				sort_case_insensitive = false,
				filesystem = {
					follow_current_file = {
						enabled = true,
					},
					use_libuv_file_watcher = true,
					filtered_items = {
						hide_dotfiles = false,
						hide_gitignored = false,
					},
				},
				window = { width = 30 },
			})
		end,
	},
	{

		-----------------------------------------------------
		--                    ZEN MODE                     --
		-----------------------------------------------------
		"folke/zen-mode.nvim", -- https://github.com/folke/zen-mode.nvim
	},
	{

		-----------------------------------------------------
		--                  STATUS BAR                     --
		-----------------------------------------------------
		"nvim-lualine/lualine.nvim", -- https://github.com/nvim-lualine/lualine.nvim
		dependencies = {
			"nvim-tree/nvim-web-devicons", -- https://github.com/nvim-tree/nvim-web-devicons
		},
		config = function()
			require("lualine").setup({
				options = {
					icons_enabled = true,
					theme = "auto",
					-- component_separators = { left = "", right = "" },
					component_separators = { left = "", right = "" },
					-- section_separators = { left = "", right = "" },
					section_separators = { left = "", right = "" },
					disabled_filetypes = {
						statusline = {},
						winbar = {},
					},
					ignore_focus = {},
					always_divide_middle = true,
					globalstatus = false,
					refresh = {
						statusline = 1000,
						tabline = 1000,
						winbar = 1000,
					},
				},
				sections = {
					lualine_a = { "mode" },
					lualine_b = { "branch", "diff", "diagnostics" },
					lualine_c = { "filename" },
					lualine_x = { "encoding", "fileformat", "filetype" },
					lualine_y = { "progress" },
					lualine_z = { "location" },
				},
				inactive_sections = {
					lualine_a = {},
					lualine_b = {},
					lualine_c = { "filename" },
					lualine_x = { "location" },
					lualine_y = {},
					lualine_z = {},
				},
				tabline = {},
				winbar = {},
				inactive_winbar = {},
				extensions = {},
			})
		end,
	},
	{

		-----------------------------------------------------
		--                   BUFFER BAR                    --
		-----------------------------------------------------
		"akinsho/bufferline.nvim", -- https://github.com/akinsho/bufferline.nvim
		config = function()
			local bufferline = require("bufferline")
			bufferline.setup({
				options = {
					hover = {
						enabled = true,
						delay = 200,
						reveal = { "close" },
					},
					separator_style = "slant", -- "slant" | "slope" | "thick" | "thin" |
				},
			})
		end,
	},
	{
		-----------------------------------------------------
		--                   GIT SIGNS                     --
		-----------------------------------------------------
		"lewis6991/gitsigns.nvim", -- https://github.com/lewis6991/gitsigns.nvim
		dependencies = {
			"nvim-lua/plenary.nvim", -- https://github.com/nvim-lua/plenary.nvim
		},
		config = function()
			require("gitsigns").setup({
				auto_attach = true,
			})
		end,
	},
	{
		-----------------------------------------------------
		--                  INDENT LINE                    --
		-----------------------------------------------------
		"lukas-reineke/indent-blankline.nvim", -- https://github.com/lukas-reineke/indent-blankline.nvim
		dependencies = {
			"HiPhish/rainbow-delimiters.nvim", -- https://github.com/HiPhish/rainbow-delimiters.nvim
		},
		config = function()
			local hooks = require("ibl.hooks")

			hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
				vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#E06C75" })
				vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#E5C07B" })
				vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#61AFEF" })
				vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#D19A66" })
				vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#98C379" })
				vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#C678DD" })
				vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#56B6C2" })
			end)

			local highlight = {
				"RainbowRed",
				"RainbowYellow",
				"RainbowBlue",
				"RainbowOrange",
				"RainbowGreen",
				"RainbowViolet",
				"RainbowCyan",
			}

			require("ibl").setup({
				scope = {
					highlight = highlight,
				},
			})

			hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)

			-- Rainbow delimiters setup
			local rainbow_delimiters = require("rainbow-delimiters")
			vim.g.rainbow_delimiters = {
				strategy = {
					[""] = rainbow_delimiters.strategy["global"],
					vim = rainbow_delimiters.strategy["local"],
				},
				query = {
					[""] = "rainbow-delimiters",
					lua = "rainbow-blocks",
				},
				priority = {
					[""] = 110,
					lua = 210,
				},
				highlight = highlight,
			}
		end,
	},
	{
		-----------------------------------------------------
		--                COLOR HIGHLIGHT                  --
		-----------------------------------------------------
		"norcalli/nvim-colorizer.lua", -- https://github.com/norcalli/nvim-colorizer.lua
		config = function()
			require("colorizer").setup()
		end,
	},
	{
		-----------------------------------------------------
		--                  TELESCOPE                      --
		-----------------------------------------------------
		"nvim-telescope/telescope.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		config = function()
			require("telescope").setup()
		end,
	},
}
