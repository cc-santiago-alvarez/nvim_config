return {
  "echasnovski/mini.map",
  version = false,
  event = "VeryLazy",
  config = function()
    local minimap = require("mini.map")

    minimap.setup({
      -- Lo que se dibuja encima del minimapa, como en VS Code
      integrations = {
        minimap.gen_integration.builtin_search(),   -- coincidencias de búsqueda
        minimap.gen_integration.diagnostic(),       -- errores y warnings del LSP
        minimap.gen_integration.gitsigns(),         -- líneas añadidas/modificadas
      },

      symbols = {
        -- Braille 4x2: cada celda condensa 4 líneas x 2 columnas de código
        encode = minimap.gen_encode_symbols.dot("4x2"),
        scroll_line = "█",  -- posición del cursor
        scroll_view = "┃",  -- porción del archivo visible en pantalla
      },

      window = {
        side = "right",
        width = 12,
        winblend = 0,
        show_integration_count = false,
      },
    })

    -- Buffers donde el minimapa no tiene sentido
    local excluidos = {
      ["neo-tree"] = true,
      ["alpha"] = true,
      ["TelescopePrompt"] = true,
      ["help"] = true,
      ["lazy"] = true,
      ["mason"] = true,
      ["dapui_scopes"] = true,
      ["dapui_breakpoints"] = true,
      ["dapui_stacks"] = true,
      ["dapui_watches"] = true,
      ["dap-repl"] = true,
      ["fugitive"] = true,
      ["qf"] = true,
    }

    local function auto_minimap()
      if excluidos[vim.bo.filetype] or vim.bo.buftype ~= "" then
        return
      end
      minimap.open()
    end

    vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
      group = vim.api.nvim_create_augroup("MinimapAuto", { clear = true }),
      callback = auto_minimap,
    })

    -- Atajos: <leader>m + ...
    local map = function(lhs, rhs, desc)
      vim.keymap.set("n", lhs, rhs, { noremap = true, silent = true, desc = desc })
    end

    map("<leader>mm", minimap.toggle, "Minimapa: mostrar/ocultar")
    map("<leader>mf", minimap.toggle_focus, "Minimapa: entrar/salir del foco")
    map("<leader>ms", minimap.toggle_side, "Minimapa: cambiar de lado")
    map("<leader>mr", minimap.refresh, "Minimapa: refrescar")
  end,
}
