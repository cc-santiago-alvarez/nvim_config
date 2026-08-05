-- Paleta "phosphor-fn": el verde predomina, blanco para keywords,
-- y el amarillo queda reservado exclusivamente a los nombres de funciones.
-- Se aplica encima del colorscheme matrix (ver plugins/colorscheme.lua).

local p = {
  bg       = "#000000",
  comment  = "#1E5A2C", -- verde apagado, se hunde en el fondo
  punct    = "#2E8F44", -- llaves, operadores, comas
  string   = "#3FBF5A",
  module   = "#4FCB68", -- nombres de paquete (bcrypt, fmt, os)
  type     = "#6EE87F",
  field    = "#8FD9A0", -- campos de struct
  variable = "#C8E6CE", -- blanco verdoso: el cuerpo del texto
  keyword  = "#FFFFFF", -- blanco puro
  func     = "#FFD84A", -- amarillo: el único uso en toda la paleta
  const    = "#D9A32E", -- ámbar apagado, subordinado al amarillo de funciones
  red      = "#FF4A3D",
  cursor   = "#FFD84A",
  cline    = "#08170D",
  sel      = "#0F3D1C",

  -- Cromo de la interfaz (no sintaxis): fondo de la pestaña activa y su texto.
  -- Sube `tab` hacia #114A24 si la quieres más marcada, bájalo a #08170D si
  -- prefieres que apenas se insinúe.
  tab      = "#0B2A16",
  bright   = "#E8FFF0", -- blanco verdoso, más claro que `variable`
}

-- Si el blanco puro cansa la vista: cambia keyword a "#E8FFF0".
-- Si quieres más amarillo, suma @constructor y @function.builtin a p.func.

local groups = {
  ["@comment"]               = { fg = p.comment },
  ["Comment"]                = { fg = p.comment },

  ["@keyword"]               = { fg = p.keyword, bold = true },
  ["@keyword.function"]      = { fg = p.keyword, bold = true },
  ["@keyword.return"]        = { fg = p.keyword, bold = true },
  ["@keyword.conditional"]   = { fg = p.keyword, bold = true },
  ["@keyword.repeat"]        = { fg = p.keyword, bold = true },
  ["@keyword.coroutine"]     = { fg = p.keyword, bold = true },
  ["@keyword.import"]        = { fg = p.keyword },
  ["@keyword.operator"]      = { fg = p.keyword },
  ["Keyword"]                = { fg = p.keyword, bold = true },
  ["Statement"]              = { fg = p.keyword, bold = true },

  -- el amarillo vive acá y en ningún otro lado
  ["@function"]              = { fg = p.func, bold = true },
  ["@function.call"]         = { fg = p.func },
  ["@function.method"]       = { fg = p.func, bold = true },
  ["@function.method.call"]  = { fg = p.func },
  ["@function.builtin"]      = { fg = p.func },
  ["Function"]               = { fg = p.func },
  ["@constructor"]           = { fg = p.type },

  ["@type"]                  = { fg = p.type },
  ["@type.builtin"]          = { fg = p.type },
  ["@type.definition"]       = { fg = p.type, bold = true },
  ["Type"]                   = { fg = p.type },

  ["@string"]                = { fg = p.string },
  ["@string.escape"]         = { fg = p.const, bold = true },
  ["@character"]             = { fg = p.string },
  ["String"]                 = { fg = p.string },

  ["@number"]                = { fg = p.const },
  ["@number.float"]          = { fg = p.const },
  ["@boolean"]               = { fg = p.const, bold = true },
  ["@constant"]              = { fg = p.const },
  ["@constant.builtin"]      = { fg = p.const, bold = true },
  ["Constant"]               = { fg = p.const },

  ["@variable"]              = { fg = p.variable },
  ["@variable.parameter"]    = { fg = p.variable },
  ["@variable.member"]       = { fg = p.field },
  ["@property"]              = { fg = p.field },
  ["@module"]                = { fg = p.module },
  ["@label"]                 = { fg = p.module },

  ["@operator"]              = { fg = p.punct },
  ["@punctuation.bracket"]   = { fg = p.punct },
  ["@punctuation.delimiter"] = { fg = p.punct },
  ["@punctuation.special"]   = { fg = p.const },

  ["Normal"]                 = { fg = p.variable, bg = p.bg },
  ["NormalNC"]               = { fg = p.variable, bg = p.bg },
  ["NormalFloat"]            = { fg = p.variable, bg = p.bg },
  ["FloatBorder"]            = { fg = p.punct,    bg = p.bg },
  ["LineNr"]                 = { fg = p.comment },
  ["CursorLineNr"]           = { fg = p.func,     bold = true },
  ["CursorLine"]             = { bg = p.cline },
  ["Visual"]                 = { bg = p.sel },
  ["Search"]                 = { fg = "#000000",  bg = p.func },
  ["IncSearch"]              = { fg = "#000000",  bg = p.keyword },
  ["MatchParen"]             = { fg = p.func,     bold = true, underline = true },
  ["StatusLine"]             = { fg = p.type,     bg = p.cline },
  ["VertSplit"]              = { fg = p.punct },
  ["WinSeparator"]           = { fg = p.punct },
  ["Pmenu"]                  = { fg = p.variable, bg = p.cline },
  ["PmenuSel"]               = { fg = "#000000",  bg = p.func, bold = true },
  ["Cursor"]                 = { fg = "#000000",  bg = p.cursor },
  ["NonText"]                = { fg = p.comment },
  ["Whitespace"]             = { fg = p.comment },

  ["DiagnosticError"]        = { fg = p.red },
  ["DiagnosticWarn"]         = { fg = p.const },
  ["DiagnosticHint"]         = { fg = p.type },
  ["DiagnosticInfo"]         = { fg = p.type },

  -- gopls pisa a treesitter con semantic tokens
  ["@lsp.type.function"]     = { link = "@function" },
  ["@lsp.type.method"]       = { link = "@function.method" },
  ["@lsp.type.type"]         = { link = "@type" },
  ["@lsp.type.struct"]       = { link = "@type" },
  ["@lsp.type.interface"]    = { link = "@type" },
  ["@lsp.type.parameter"]    = { link = "@variable.parameter" },
  ["@lsp.type.property"]     = { link = "@property" },
  ["@lsp.type.namespace"]    = { link = "@module" },
  ["@lsp.type.keyword"]      = { link = "@keyword" },
  ["@lsp.type.string"]       = { link = "@string" },
  ["@lsp.type.number"]       = { link = "@number" },

  -- El minimapa hereda el fondo negro y dibuja los puntos en verde apagado
  ["MiniMapNormal"]          = { fg = p.punct,   bg = p.bg },
  ["MiniMapSymbolLine"]      = { fg = p.func,    bg = p.bg },
  ["MiniMapSymbolView"]      = { fg = p.type,    bg = p.bg },
  ["MiniMapSymbolCount"]     = { fg = p.module,  bg = p.bg },
}

local M = {}

M.palette = p

function M.apply()
  for group, opts in pairs(groups) do
    vim.api.nvim_set_hl(0, group, opts)
  end
end

function M.setup()
  -- Se vuelve a aplicar si recargas el colorscheme (:colorscheme matrix)
  vim.api.nvim_create_autocmd("ColorScheme", {
    group = vim.api.nvim_create_augroup("PhosphorFn", { clear = true }),
    callback = M.apply,
  })

  M.apply()
end

return M
