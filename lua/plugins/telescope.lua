return {
  "nvim-telescope/telescope.nvim",
  event = "VeryLazy",  -- Lazy load when VimEnter event is triggered
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope-file-browser.nvim",
    {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make",
    },
    {
      "nvim-telescope/telescope-ui-select.nvim",  -- Añadir el plugin de UI select
    }
  },
  config = function()
    local telescope = require("telescope")
    local actions = require("telescope.actions")

    telescope.setup({
      defaults = {
        prompt_prefix = "> ",
        selection_caret = " ",
        path_display = { "smart" },
        mappings = {
          i = {
            ["<C-n>"] = actions.cycle_history_next,
            ["<C-p>"] = actions.cycle_history_prev,
            ["<C-c>"] = actions.close,
            ["<Down>"] = actions.move_selection_next,
            ["<Up>"] = actions.move_selection_previous,
            ["<CR>"] = actions.select_default,
            ["<C-x>"] = actions.select_horizontal,
            ["<C-v>"] = actions.select_vertical,
            ["<C-t>"] = actions.select_tab,
          },
        },
      },
      pickers = {
        find_files = {},
        live_grep = {},
				 buffers = {
          previewer = false,
        },
        help_tags = {},
        git_files = {},
        git_status = {},
        git_branches = {},
        git_commits = {},
      },
      extensions = {
        fzf = {
          fuzzy = true,
          override_generic_sorter = true,
          override_file_sorter = true,
           case_mode = "smart_case",
        },
        ["ui-select"] = {  -- Configuración del plugin telescope-ui-select
          require("telescope.themes").get_dropdown {
            -- Puedes personalizar el aspecto aquí
            -- ejemplo: ancho, altura, borde, etc.
          }
        }
      },
    })

    telescope.load_extension("fzf")
    telescope.load_extension("file_browser")
     telescope.load_extension("ui-select")  -- Cargar la extensión ui-select

    -- Keybindings for Telescope commands
    local map = vim.api.nvim_set_keymap
    local opts = { noremap = true, silent = true }

    -- Telescope key mappings
    map("n", "<leader>fc", "<cmd>Telescope colorscheme<cr>", opts)
    map("n", "<leader>ff", "<cmd>Telescope find_files<cr>", opts)
    map("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", opts)
    map("n", "<leader>fo", "<cmd>Telescope oldfiles<cr>", opts)

    -- Search-related mappings
    map("n", "<leader>sh", "<cmd>Telescope help_tags<cr>", opts)
    map("n", "<leader>sm", "<cmd>Telescope man_pages<cr>", opts)
    map("n", "<leader>sk", "<cmd>Telescope keymaps<cr>", opts)
    map("n", "<leader>sc", "<cmd>Telescope commands<cr>", opts)

    -- Git-related mappings
    map("n", "<leader>gf", "<cmd>Telescope git_files<cr>", opts)
    map("n", "<leader>gs", "<cmd>Telescope git_status<cr>", opts)
    map("n", "<leader>gc", "<cmd>Telescope git_commits<cr>", opts)
    map("n", "<leader>gb", "<cmd>Telescope git_branches<cr>", opts)

    -- Buffers mapping
    map("n", "<leader>bf", "<cmd>Telescope buffers<cr>", opts)

    -- Command prompt binding (command line input)
    map("n", "<leader>sl", "<cmd>Telescope command_history<cr>", opts)
  end,
}
