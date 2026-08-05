return {
  "akinsho/bufferline.nvim",
  version = "*",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  event = "VeryLazy",
  config = function()
    local p = require("config.phosphor").palette

    -- Colores derivados de la paleta phosphor: el amarillo sigue reservado
    -- para funciones, así que la pestaña activa se marca con blanco verdoso
    -- + indicador verde brillante, y las inactivas se hunden en verde apagado.
    -- Con indicator.style = "underline", bufferline dibuja el subrayado de la
    -- pestaña activa usando `sp` (por defecto el fondo de TabLineSel, que sobre
    -- negro quedaría invisible), así que lo forzamos a verde brillante.
    -- La pestaña activa lleva fondo propio (p.tab) para que parezca levantada
    -- sobre el negro; las demás se hunden. Todo lo que se pinta DENTRO de ella
    -- (número, icono de modificado, botón de cerrar, diagnósticos) tiene que
    -- compartir ese fondo, o se abren huecos negros dentro de la pestaña.
    local function activa(fg, extra)
      return vim.tbl_extend("force",
        { fg = fg, bg = p.tab, sp = p.type }, extra or {})
    end

    local inactiva = { fg = p.punct, bg = p.bg }
    local visible  = { fg = p.field, bg = p.bg }

    require("bufferline").setup({
      options = {
        mode = "buffers",           -- pestañas = buffers abiertos, como en VS Code
        numbers = "ordinal",        -- muestra 1, 2, 3... para saltar con <A-n>
        close_command = "bdelete! %d",
        left_mouse_command = "buffer %d",      -- clic izquierdo abre la pestaña
        middle_mouse_command = "bdelete! %d",  -- clic central cierra, como en VS Code
        right_mouse_command = false,           -- clic derecho desactivado (por defecto cerraba)
        indicator = { style = "underline" },
        diagnostics = "nvim_lsp",
        diagnostics_indicator = function(count, level)
          return (level:match("error") and " " or " ") .. count
        end,
        separator_style = "thin",
        show_buffer_close_icons = true,
        show_close_icon = false,
        always_show_bufferline = true,
        offsets = {
          {
            filetype = "neo-tree",
            text = "EXPLORADOR",
            text_align = "left",
            separator = true,
          },
        },
      },

      highlights = {
        fill                 = { bg = p.bg },
        background           = inactiva,
        buffer_visible       = visible,
        buffer_selected      = activa(p.bright, { bold = true }),

        numbers              = inactiva,
        numbers_visible      = visible,
        numbers_selected     = activa(p.type, { bold = true }),

        separator            = { fg = p.cline, bg = p.bg },
        separator_visible    = { fg = p.cline, bg = p.bg },
        -- se funde con la pestaña activa: sin esto queda un corte negro al borde
        separator_selected   = { fg = p.tab,   bg = p.tab },
        offset_separator     = { fg = p.cline, bg = p.bg },

        indicator_selected   = activa(p.type),
        indicator_visible    = { fg = p.bg, bg = p.bg },

        close_button          = inactiva,
        close_button_visible  = visible,
        close_button_selected = activa(p.red),

        modified             = { fg = p.const, bg = p.bg },
        modified_visible     = { fg = p.const, bg = p.bg },
        modified_selected    = activa(p.const, { bold = true }),

        duplicate            = { fg = p.comment, bg = p.bg, italic = false },
        duplicate_visible    = { fg = p.comment, bg = p.bg, italic = false },
        duplicate_selected   = activa(p.field, { italic = false }),

        error                = { fg = p.red,   bg = p.bg },
        error_visible        = { fg = p.red,   bg = p.bg },
        error_selected       = activa(p.red, { bold = true }),
        error_diagnostic     = { fg = p.red,   bg = p.bg },
        warning              = { fg = p.const, bg = p.bg },
        warning_visible      = { fg = p.const, bg = p.bg },
        warning_selected     = activa(p.const, { bold = true }),
        warning_diagnostic   = { fg = p.const, bg = p.bg },
        info                 = { fg = p.type,  bg = p.bg },
        info_visible         = { fg = p.type,  bg = p.bg },
        info_selected        = activa(p.type, { bold = true }),
        hint                 = { fg = p.type,  bg = p.bg },
        hint_visible         = { fg = p.type,  bg = p.bg },
        hint_selected        = activa(p.type, { bold = true }),
      },
    })

    local map = function(lhs, rhs, desc)
      vim.keymap.set("n", lhs, rhs, { noremap = true, silent = true, desc = desc })
    end

    -- Navegar entre pestañas
    map("]b", "<cmd>BufferLineCycleNext<cr>", "Pestaña siguiente")
    map("[b", "<cmd>BufferLineCyclePrev<cr>", "Pestaña anterior")

    -- Abrir una pestaña nueva y vacía (el equivalente a Ctrl+N de VS Code)
    map("<leader>bn", "<cmd>enew<cr>", "Pestaña nueva (buffer vacío)")

    -- Rueda del ratón SOBRE la barra de pestañas: pasa de una pestaña a otra.
    -- Fuera de la barra la rueda sigue haciendo scroll normal de la ventana
    -- que esté debajo del puntero, así que no se pierde el comportamiento de siempre.
    local function rueda(comando, tecla)
      return function()
        local pos = vim.fn.getmousepos()

        -- winid == 0 y screenrow == 1 => el puntero está sobre la tabline
        if pos.winid == 0 and pos.screenrow == 1 then
          vim.cmd(comando)
          return
        end

        if pos.winid ~= 0 and vim.api.nvim_win_is_valid(pos.winid) then
          vim.api.nvim_win_call(pos.winid, function()
            vim.cmd("normal! 3" .. tecla)
          end)
        end
      end
    end

    vim.keymap.set({ "n", "v" }, "<ScrollWheelDown>",
      rueda("BufferLineCycleNext", "\5"),   -- \5 = <C-e>, scroll hacia abajo
      { noremap = true, silent = true, desc = "Rueda abajo: pestaña siguiente / scroll" })

    vim.keymap.set({ "n", "v" }, "<ScrollWheelUp>",
      rueda("BufferLineCyclePrev", "\25"),  -- \25 = <C-y>, scroll hacia arriba
      { noremap = true, silent = true, desc = "Rueda arriba: pestaña anterior / scroll" })

    -- Mover la pestaña actual de sitio
    map("]B", "<cmd>BufferLineMoveNext<cr>", "Mover pestaña a la derecha")
    map("[B", "<cmd>BufferLineMovePrev<cr>", "Mover pestaña a la izquierda")

    -- Saltar directo a la pestaña N (el número que se ve en la pestaña)
    for i = 1, 9 do
      map("<A-" .. i .. ">", function()
        require("bufferline").go_to(i, true)
      end, "Ir a la pestaña " .. i)
    end

    -- Vim nunca permite cero buffers: al cerrar el último archivo se inventa uno
    -- vacío [No Name]. No se puede evitar que exista, pero sí que sea lo que ves.
    -- En su lugar mostramos el dashboard, como el "no editors open" de VS Code.
    local function archivos_abiertos()
      local n = 0
      for _, b in ipairs(vim.api.nvim_list_bufs()) do
        if vim.bo[b].buflisted and vim.api.nvim_buf_get_name(b) ~= "" then
          n = n + 1
        end
      end
      return n
    end

    -- ¿es un buffer vacío sin nombre, de los que se inventa Vim?
    local function es_fantasma(b)
      if not vim.api.nvim_buf_is_valid(b) then return false end
      if not vim.bo[b].buflisted then return false end
      if vim.api.nvim_buf_get_name(b) ~= "" then return false end
      if vim.bo[b].modified then return false end
      if vim.api.nvim_buf_line_count(b) > 1 then return false end
      return (vim.api.nvim_buf_get_lines(b, 0, 1, false)[1] or "") == ""
    end

    -- Borra los buffers fantasma que no estén a la vista en ninguna ventana.
    -- Lo de "a la vista" importa: si abriste una pestaña vacía a propósito
    -- con <leader>bn, está en una ventana y no se toca.
    local function limpiar_fantasmas()
      for _, b in ipairs(vim.api.nvim_list_bufs()) do
        if es_fantasma(b) and #vim.fn.win_findbuf(b) == 0 then
          pcall(vim.api.nvim_buf_delete, b, {})
        end
      end
    end

    local function mostrar_dashboard()
      -- no robarle la ventana a neo-tree, al minimapa ni a un terminal
      if vim.bo.buftype ~= "" or vim.bo.filetype == "alpha" then return end
      pcall(vim.cmd, "Alpha")
      -- el dashboard ya ocupa la ventana, así que el fantasma que Vim pudo
      -- haber creado antes de llegar aquí queda libre y se puede borrar
      limpiar_fantasmas()
    end

    local function cerrar_pestana()
      local actual = vim.api.nvim_get_current_buf()

      if archivos_abiertos() <= 1 then
        mostrar_dashboard()
        pcall(vim.cmd, "bdelete " .. actual)
        return
      end

      -- pasamos a la pestaña siguiente antes de borrar, así la ventana
      -- se queda con un archivo real en vez de con el buffer vacío
      vim.cmd("BufferLineCycleNext")
      pcall(vim.cmd, "bdelete " .. actual)
    end

    -- Cubre el clic central y cualquier :bd suelto, no sólo <leader>bc
    local grupo = vim.api.nvim_create_augroup("BufferlineDashboard", { clear = true })

    -- BufWipeout además de BufDelete: el buffer de alpha es bufhidden=wipe, así
    -- que un :bd estando en el dashboard sólo emite el primero de los dos.
    vim.api.nvim_create_autocmd({ "BufDelete", "BufWipeout" }, {
      group = grupo,
      callback = function(ev)
        -- Si lo que se cierra es el propio dashboard, es porque te estás yendo
        -- a algún sitio (abrir archivo, ":ene" del botón New file). No lo
        -- reabrimos: si no, el botón New file no llegaría a ninguna parte.
        local era_dashboard = vim.api.nvim_buf_is_valid(ev.buf)
          and vim.bo[ev.buf].filetype == "alpha"

        vim.schedule(function()
          if archivos_abiertos() > 0 then
            limpiar_fantasmas()
          elseif not era_dashboard and es_fantasma(vim.api.nvim_get_current_buf()) then
            -- sólo tomamos la ventana si lo que queda a la vista es un fantasma;
            -- si ya hay un archivo cargado, no le pisamos encima el dashboard
            mostrar_dashboard()
          end
        end)
      end,
    })

    -- Al abrir un archivo, barre cualquier fantasma que se haya colado por otro lado
    vim.api.nvim_create_autocmd("BufReadPost", {
      group = grupo,
      callback = function() vim.schedule(limpiar_fantasmas) end,
    })

    -- La barra de pestañas no tiene nada que pintar en el dashboard
    vim.api.nvim_create_autocmd("User", {
      group = grupo,
      pattern = "AlphaReady",
      callback = function() vim.opt.showtabline = 0 end,
    })

    vim.api.nvim_create_autocmd("User", {
      group = grupo,
      pattern = "AlphaClosed",
      callback = function() vim.opt.showtabline = 2 end,
    })

    -- Acciones sobre pestañas: <leader>b + ...
    map("<leader>bc", cerrar_pestana,                        "Cerrar la pestaña actual")
    map("<leader>bo", "<cmd>BufferLineCloseOthers<cr>",      "Cerrar todas menos esta")
    map("<leader>bl", "<cmd>BufferLineCloseRight<cr>",       "Cerrar las de la derecha")
    map("<leader>bh", "<cmd>BufferLineCloseLeft<cr>",        "Cerrar las de la izquierda")
    map("<leader>bp", "<cmd>BufferLineTogglePin<cr>",        "Fijar/soltar la pestaña")
    map("<leader>bs", "<cmd>BufferLinePick<cr>",             "Saltar a una pestaña por letra")

    -- Con indicator.style = "underline", bufferline pinta un espacio a la
    -- izquierda de la pestaña activa usando indicator_selected, y reconstruye
    -- ese grupo por su cuenta ignorando lo que le pasemos en `highlights`.
    -- Sin esto queda una muesca negra en el borde de la pestaña.
    -- fg = bg para que el espacio no se vea; underline para que el subrayado
    -- verde recorra la pestaña entera, de borde a borde.
    local function parchear_indicador()
      vim.api.nvim_set_hl(0, "BufferLineIndicatorSelected", {
        fg = p.tab, bg = p.tab, sp = p.type, underline = true,
      })
    end

    parchear_indicador()

    vim.api.nvim_create_autocmd("ColorScheme", {
      group = vim.api.nvim_create_augroup("BufferlineIndicador", { clear = true }),
      callback = function() vim.schedule(parchear_indicador) end,
    })
  end,
}
