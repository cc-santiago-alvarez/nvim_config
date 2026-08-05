-- Líder global para keymaps
vim.g.mapleader = " "  -- Establece la tecla líder a espacio

-- Opciones de visualización
vim.opt.number = true  -- Muestra el número de línea
--vim.opt.relativenumber = true  -- Muestra números de línea relativos para facilitar la navegación
--vim.opt.cursorline = true  -- Resalta la línea actual donde está el cursor
vim.opt.termguicolors = true  -- Habilita colores de terminal 24-bit
vim.opt.signcolumn = "yes"  -- Muestra siempre la columna de signos (usada por lsp, git, etc.)
vim.opt.wrap = false  -- No envuelve las líneas largas

-- Opciones de edición
vim.opt.mouse = 'a'  -- Habilita el uso del ratón en todas las ventanas
vim.opt.clipboard = "unnamedplus"  -- Usa el portapapeles del sistema para copiar y pegar
vim.opt.tabstop = 2  -- Número de espacios que representa un tabulador
vim.opt.shiftwidth = 2  -- Número de espacios usados para la indentación
vim.opt.expandtab = true  -- Convierte tabuladores en espacios
vim.opt.smartindent = true  -- Habilita la indentación automática inteligente
vim.opt.autoindent = true  -- Copia la indentación de la línea actual cuando se crea una nueva línea

-- Opciones de búsqueda
vim.opt.ignorecase = true  -- Ignora mayúsculas/minúsculas en búsquedas
vim.opt.smartcase = true  -- Ignora mayúsculas/minúsculas a menos que se use una mayúscula en la búsqueda
vim.opt.incsearch = true  -- Muestra resultados parciales de búsqueda mientras se escribe
vim.opt.hlsearch = false  -- No resalta todas las coincidencias de búsqueda después de la búsqueda

-- Opciones de división de ventanas
vim.opt.splitbelow = true  -- Nuevas ventanas horizontales se abren abajo de la ventana actual
vim.opt.splitright = true  -- Nuevas ventanas verticales se abren a la derecha de la ventana actual

-- Opciones de historial y deshacer
vim.opt.undofile = true  -- Habilita el historial de deshacer persistente
vim.opt.undodir = vim.fn.stdpath("cache") .. "/undo"  -- Ubicación del archivo de deshacer persistente
vim.opt.history = 1000  -- Aumenta el tamaño del historial de comandos

-- Opciones de apariencia y estilo
vim.opt.showmode = false  -- No muestra el modo de edición actual (reemplazado por el statusline)
vim.opt.showcmd = true  -- Muestra el comando actual en la línea de estado mientras se escribe
vim.opt.cmdheight = 1  -- Altura de la línea de comandos (usualmente 1 o 2)
vim.opt.laststatus = 3  -- Muestra una única línea de estado global
vim.opt.scrolloff = 8  -- Mantiene 8 líneas visibles arriba/abajo del cursor
vim.opt.sidescrolloff = 8  -- Mantiene 8 columnas visibles a la izquierda/derecha del cursor

-- Opciones de tema (tema "matrix" por ejemplo)
vim.g.matrix_contrast = false  -- false: paneles flotantes y sidebars usan el mismo fondo que el editor
vim.g.matrix_borders = false
vim.g.matrix_disable_background = false
vim.g.matrix_italic = false
