return {
  "goolord/alpha-nvim",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
    "nvim-telescope/telescope.nvim",
  },
  config = function()
    local alpha = require("alpha")
    local dashboard = require("alpha.themes.dashboard")

    -- Nueva imagen ASCII más pequeña
    local header_art = [[⠀⠀

    ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠂⠀⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡀⠀⠀⢀⠀⢀⠀⠀⡀⠠⠀⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠠⠀⠠⠀⠂⠈⠀⢂⠀⠂⢀⠀⠀⠀⠀⠀⠀⠀⡀⢠⠠⡠⠢⡠⡢⢄⠔⠁⡀⡀⠡⠀⢀⠀⠀⠀⠀⠀⠀⢀⠐⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠐⠀⠀⠀⠀⠀⠀⠀⠀⡀⢂⠂⠄⠂⢔⠱⡐⢔⢄⢣⢑⢅⢇⢪⢘⢔⢌⠆⢅⢊⠠⢐⠀⠄⠀⡀⠈⡀⡀⠡⢐⢀⠂⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠐⠀⠅⠌⠄⠅⡐⠀⢀⠐⠌⠌⢌⠢⡑⢌⠢⡱⡨⡢⡣⡣⡊⡆⡕⢔⢑⢑⠄⢕⢐⢀⠈⢐⠠⠁⢂⠠⠑⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⡐⠠⢀⠡⠀⡂⠠⢈⠌⢌⠢⡑⢌⢂⠣⡪⢢⢣⠪⡊⡎⡆⠥⡑⢌⠢⠡⡑⡐⠄⠅⠄⠐⢈⠠⠠⢐⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡐⢀⠂⠠⢁⠂⠅⡂⡑⠄⢕⠨⡐⠄⢕⢸⢨⠢⡣⡣⡣⡣⡱⡨⢂⠌⢂⠢⠨⠪⠨⠨⡐⡀⠂⢂⠐⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠐⠀⠌⡈⡐⡈⡂⠪⠈⠈⠄⠀⠀⠁⠅⠕⡜⢜⢸⢸⡸⡸⡐⡅⠅⠠⠀⠀⠁⠁⠡⡑⡐⡀⠅⡀⠂⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠀⢂⠐⠠⠂⠌⠐⠈⠀⠀⠐⠀⠀⡁⢕⢘⢌⢎⢎⢎⢎⢪⢨⢊⠄⠐⠐⠀⠀⠀⠐⡐⢄⠡⠐⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢁⠐⠨⢈⢀⠁⡀⠀⠀⢀⠀⠄⡁⠌⡂⡊⡂⢇⢇⢇⢇⢇⢇⠆⡅⠅⠂⡀⠀⢁⠠⠐⢐⠈⠄⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢐⠈⠌⠄⡐⠨⡐⠌⢔⢐⢐⠌⡢⢑⢌⢎⢪⢸⠨⢪⠪⡪⡲⡱⡱⡡⡃⡢⢊⠢⡊⢌⢐⠨⢐⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡊⡈⠄⠂⠅⡂⡁⡂⠢⠡⠡⡨⡸⡸⡸⡘⡌⢎⠢⠣⡑⠱⡱⡱⡱⣑⢌⠢⠡⡈⡂⠢⠨⢐⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡂⡐⠈⠄⡁⠄⠄⠄⢅⠑⢅⢎⢪⢊⠎⠌⠌⠂⠁⠁⠈⠈⢈⠸⠸⡸⡸⡘⡔⡐⠄⠅⡁⡂⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡀⡂⠡⠐⡀⠂⠌⡐⡐⢌⠪⠢⡣⡑⠁⠁⠀⠀⠄⠁⠀⠁⠀⠀⠈⠪⡪⡪⡒⠌⢌⠐⡐⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠂⢂⠐⢀⠁⡐⢐⠨⢐⠨⠨⠢⡂⠀⠀⠀⠀⠀⠀⠀⠁⠀⠀⠀⡘⢔⢱⠨⡨⠐⡀⢂⠂⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠂⠄⠂⡀⠂⢐⠠⠨⢐⠨⡘⡌⡢⠐⠀⠀⠀⠀⠀⠀⠀⠀⢀⠀⠌⡎⡎⢎⠢⡂⠄⠅⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠀⢀⠐⠠⠀⡂⠅⠢⠑⢌⢂⠂⠂⢀⠀⠀⠈⠀⠀⠐⠈⠀⢀⠑⢌⢊⠪⡨⠂⠌⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢂⠁⠄⢂⠡⠡⢑⠀⡂⠈⠄⠠⠀⠐⠀⠀⠀⢀⠀⠄⠂⢈⠐⡐⡁⡂⡑⠄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠅⠄⠂⠡⠐⡀⠂⠈⠀⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠄⠐⢀⠀⡂⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠠⠈⠀⠡⠀⠄⠀⠂⠁⠀⠈⠀⠐⠀⠈⠀⠈⠀⠀⠀⠠⠀⢐⠀⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠁⠂⢁⠠⢀⠀⡀⠀⠀⠀⠀⠀⠀⠀⠀⡀⠐⠈⡀⠈⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠄⢂⠐⡀⢂⢁⢂⠐⠠⠐⡀⠌⠠⠐⠈⠄⠐⠈⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠂⡐⢐⢀⠂⠌⡐⠡⢐⠈⠄⠡⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠐⢀⠂⠌⠀⠂⠁⠀⠀⠀⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
		]]

    -- Texto ASCII adicional
    local footer_art = [[
 ________  ________  ________  ________     
|\   __  \|\   __  \|\   ____\|\   __  \    
\ \  \|\  \ \  \|\  \ \  \___|\ \  \|\  \   
 \ \   ____\ \  \\\  \ \  \  __\ \  \\\  \  
  \ \  \___|\ \  \\\  \ \  \|\  \ \  \\\  \ 
   \ \__\    \ \_______\ \_______\ \_______\
    \|__|     \|_______|\|_______|\|_______|
                                           
]]

  -- Función para dividir un string en líneas
    local function split_string(inputstr, sep)
      sep = sep or "\n"
      local t = {}
      for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
        table.insert(t, str)
      end
      return t
    end

    -- Configurar el header usando la función de división
    dashboard.section.header.val = split_string(header_art)

    -- Añadir el footer al header
    for _, line in ipairs(split_string(footer_art)) do
      table.insert(dashboard.section.header.val, line)
    end

    -- Centrar el contenido del dashboard
    local function center_text(text)
      local dashboard_width = 80 -- Ajusta este valor a tu gusto
      local lines = {}
      for _, line in ipairs(text) do
        local line_width = vim.fn.strdisplaywidth(line) -- Usar strdisplaywidth para calcular correctamente el ancho
        local padding = math.floor((dashboard_width - line_width) / 2)
        table.insert(lines, string.rep(" ", padding) .. line)
      end
      return lines
    end

    dashboard.section.header.val = center_text(dashboard.section.header.val)

    -- Asegúrate de que 'buttons' esté inicializado
    dashboard.section.buttons = dashboard.section.buttons or { val = {} }

    -- Configuración de los botones
    dashboard.section.buttons.val = {
      dashboard.button("p", "  Find project", ":Telescope find_files cwd=~/Projects<CR>"),
      dashboard.button("n", "  New file", ":ene <BAR> startinsert <CR>"),
      dashboard.button("f", "  Find file", ":Telescope find_files <CR>"),
      dashboard.button("t", "  Find text", ":Telescope live_grep <CR>"),
      dashboard.button("m", "  Open current file", ":e %<CR>"),  -- Nuevo botón para abrir el archivo actual
      dashboard.button("g", "  Chat with AI", ":Gen<CR>"),  -- Nuevo botón para interactuar con gen.nvim
     -- dashboard.button("m", "  BookMarks", ":Telescope marks <CR>"),
      dashboard.button("e", "  Extensions", ":e ~/.config/nvim/lua/VisualStudioNeovim/Core/plugins.lua<CR>"),
      dashboard.button("r", "  Recently used files", ":Telescope oldfiles <CR>"),
      dashboard.button("c", "  Configuration", ":e $MYVIMRC<CR>"),
      dashboard.button("q", "  Quit Neovim", ":qa<CR>"),
    }

    -- Configuración del dashboard
    alpha.setup(dashboard.opts)

    -- Ajustes adicionales
    vim.cmd([[ autocmd FileType alpha setlocal nofoldenable ]])
  end,
} 
