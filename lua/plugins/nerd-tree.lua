return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
  },
  config = function()
    -- Configuración de Neo-tree
    require('neo-tree').setup({
      window = {
        mappings = {
          ["<leader>e"] = "toggle",  -- Abre/cierra Neo-tree con <leader>e
          ["<leader>q"] = "close_window",  -- Cierra la ventana de Neo-tree
          ["<leader>bf"] = { "toggle", "buffers" },  -- Muestra buffers abiertos en Neo-tree float
        },
      },
      filesystem = {
        follow_current_file = { enabled = true },  -- Sigue el archivo actual
        use_libuv_file_watcher = true,  -- Usa el observador de archivos de libuv
      },
      buffers = {
        follow_current_file = { enabled = true },  -- Sigue el buffer actual
      },
    })

    -- Keymaps adicionales para comandos específicos
    vim.api.nvim_set_keymap('n', '<leader>e', ':Neotree toggle<CR>', { noremap = true, silent = true })
    vim.api.nvim_set_keymap('n', '<leader>bf', ':Neotree toggle buffers<CR>', { noremap = true, silent = true })
    vim.api.nvim_set_keymap('n', '<leader>q', ':Neotree close<CR>', { noremap = true, silent = true })
  end,
}

