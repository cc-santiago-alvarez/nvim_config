return {
  {
    'iruzo/matrix-nvim',
    lazy = false, -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
      -- El tema matrix pinta el fondo con #0D0208 (negro azulado).
      -- Aquí lo sustituimos por negro puro en todos los grupos de resaltado.
      local THEME_BG = 0x0D0208
      local BLACK = 0x000000

      local function fondo_negro()
        for name, hl in pairs(vim.api.nvim_get_hl(0, {})) do
          -- los grupos enlazados heredan del destino, no hace falta tocarlos
          if not hl.link and hl.bg == THEME_BG then
            hl.bg = BLACK
            vim.api.nvim_set_hl(0, name, hl)
          end
        end

        -- Grupos que el tema no define y que Neovim deja con el fondo por defecto
        for _, group in ipairs({
          "Normal",
          "NormalNC",
          "NormalFloat",
          "EndOfBuffer",
          "SignColumn",
          "FoldColumn",
          "MsgArea",
          "WinBar",
          "WinBarNC",
        }) do
          local hl = vim.api.nvim_get_hl(0, { name = group, link = false })
          hl.bg = BLACK
          vim.api.nvim_set_hl(0, group, hl)
        end
      end

      -- Se re-aplica si vuelves a cargar el colorscheme (:colorscheme matrix)
      vim.api.nvim_create_autocmd("ColorScheme", {
        pattern = "matrix",
        callback = fondo_negro,
      })

      -- load the colorscheme here
      vim.cmd.colorscheme("matrix")

      -- Paleta propia encima de matrix: verde de base, keywords en blanco,
      -- amarillo sólo para funciones. Registra su propio autocmd ColorScheme,
      -- que corre después de fondo_negro, así que tiene la última palabra.
      require("config.phosphor").setup()
    end,
  }
}
