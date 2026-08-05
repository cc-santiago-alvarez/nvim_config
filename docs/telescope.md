# Telescope — Guía de comandos

Referencia de los comandos y atajos de [Telescope](https://github.com/nvim-telescope/telescope.nvim)
tal como está configurado en `lua/plugins/telescope.lua`.

**Tecla líder (`<leader>`): barra espaciadora** (definida en `lua/config/options.lua`).

---

## Atajos configurados

### Archivos y búsqueda

| Atajo | Comando | Descripción |
|---|---|---|
| `<leader>ff` | `:Telescope find_files` | Buscar archivos por nombre |
| `<leader>fg` | `:Telescope live_grep` | Buscar texto dentro de los archivos del proyecto |
| `<leader>fo` | `:Telescope oldfiles` | Archivos abiertos recientemente |
| `<leader>fc` | `:Telescope colorscheme` | Cambiar el tema de colores |
| `<leader>bf` | `:Telescope buffers` | Listar y saltar entre buffers abiertos |

### Ayuda e introspección

| Atajo | Comando | Descripción |
|---|---|---|
| `<leader>sh` | `:Telescope help_tags` | Buscar en la ayuda de Neovim |
| `<leader>sk` | `:Telescope keymaps` | Ver todos los atajos de teclado definidos |
| `<leader>sc` | `:Telescope commands` | Listar los comandos disponibles |
| `<leader>sm` | `:Telescope man_pages` | Buscar en las páginas del manual (man) |
| `<leader>sl` | `:Telescope command_history` | Historial de comandos ejecutados |

### Git

| Atajo | Comando | Descripción |
|---|---|---|
| `<leader>gf` | `:Telescope git_files` | Archivos versionados en el repositorio |
| `<leader>gs` | `:Telescope git_status` | Archivos con cambios sin confirmar |
| `<leader>gc` | `:Telescope git_commits` | Historial de commits |
| `<leader>gb` | `:Telescope git_branches` | Listar y cambiar de rama |

---

## Atajos dentro del buscador (modo inserción)

| Tecla | Acción |
|---|---|
| *(escribir)* | Filtra los resultados de forma difusa (fuzzy) |
| `<Down>` / `<Up>` | Bajar / subir en la lista de resultados |
| `<C-n>` / `<C-p>` | Navegar por el historial de búsquedas previas |
| `<CR>` | Abrir el resultado seleccionado |
| `<C-v>` | Abrir en división vertical |
| `<C-x>` | Abrir en división horizontal |
| `<C-t>` | Abrir en una pestaña nueva |
| `<C-c>` | Cerrar el buscador |
| `<Esc>` | Pasar a modo normal dentro del buscador |

En modo normal dentro del buscador (tras pulsar `<Esc>`) están disponibles los
mapeos por defecto de Telescope: `j`/`k` para moverse, `q` para cerrar,
`?` para ver todos los mapeos activos del buscador.

---

## Uso manual

Cualquier buscador se puede invocar sin atajo:

```vim
:Telescope find_files
:Telescope live_grep
```

Escribe `:Telescope` y pulsa `<Tab>` para autocompletar y ver la lista completa
de buscadores disponibles.

También se pueden pasar opciones:

```vim
" Buscar incluyendo archivos ocultos
:Telescope find_files hidden=true

" Buscar en un directorio concreto
:Telescope find_files cwd=~/proyectos

" Buscar una palabra concreta con grep
:Telescope grep_string search=miFuncion
```

Desde Lua:

```lua
require("telescope.builtin").find_files({ hidden = true })
```

---

## Otros buscadores útiles (sin atajo asignado)

| Comando | Descripción |
|---|---|
| `:Telescope grep_string` | Buscar la palabra bajo el cursor en todo el proyecto |
| `:Telescope current_buffer_fuzzy_find` | Buscar dentro del archivo actual |
| `:Telescope resume` | Reabrir el último buscador con su búsqueda intacta |
| `:Telescope registers` | Ver el contenido de los registros |
| `:Telescope marks` | Listar las marcas |
| `:Telescope jumplist` | Lista de saltos |
| `:Telescope quickfix` | Contenido de la lista quickfix |
| `:Telescope diagnostics` | Diagnósticos del LSP (errores y avisos) |
| `:Telescope lsp_references` | Referencias al símbolo bajo el cursor |
| `:Telescope lsp_definitions` | Definiciones del símbolo bajo el cursor |
| `:Telescope lsp_document_symbols` | Símbolos del archivo actual |
| `:Telescope treesitter` | Símbolos detectados por Treesitter |
| `:Telescope search_history` | Historial de búsquedas `/` |
| `:Telescope autocommands` | Autocomandos definidos |
| `:Telescope highlights` | Grupos de resaltado disponibles |

---

## Extensiones instaladas

### `fzf-native`

Sustituye el algoritmo de ordenación por una implementación en C, mucho más
rápida en proyectos grandes. Se activa de forma transparente en todos los
buscadores. Configurado con `case_mode = "smart_case"`: si escribes todo en
minúsculas ignora mayúsculas y minúsculas; si escribes alguna mayúscula, la
búsqueda pasa a distinguirlas.

Sintaxis de búsqueda que habilita:

| Patrón | Significado |
|---|---|
| `foo` | Coincidencia difusa |
| `'foo` | Coincidencia exacta de `foo` |
| `^foo` | Empieza por `foo` |
| `foo$` | Termina en `foo` |
| `!foo` | No contiene `foo` |

### `file-browser`

Navegador de archivos que permite crear, renombrar y borrar desde el propio
buscador. **No tiene atajo asignado**, se usa con:

```vim
:Telescope file_browser
:Telescope file_browser path=%:p:h
```

Dentro del navegador: `c` crear, `r` renombrar, `d` borrar, `m` mover,
`<C-g>` subir un directorio.

### `ui-select`

Hace que los menús de selección nativos de Neovim (`vim.ui.select`) — por
ejemplo las acciones de código del LSP — se muestren con la interfaz de
Telescope, en formato desplegable.

---

## Notas sobre la configuración actual

- **Conflicto en `<leader>s`**: `lua/config/keymaps.lua` mapea `<leader>s` a
  `:split`. Como no hay un `timeoutlen` definido, Neovim espera 1 segundo antes
  de decidir. Los atajos `<leader>sh`, `<leader>sk`, `<leader>sc`, `<leader>sm`
  y `<leader>sl` solo funcionan si se escriben dentro de ese segundo; si hay una
  pausa, se abre una división horizontal.
- El buscador de **buffers** tiene la previsualización desactivada
  (`previewer = false`).
- `path_display = { "smart" }`: las rutas se acortan mostrando solo la parte
  necesaria para distinguir un archivo de otro.
- Telescope se carga de forma diferida con el evento `VeryLazy`.

---

## Dependencias externas

Para que `live_grep` y `find_files` funcionen a pleno rendimiento conviene
tener instalados:

- **ripgrep** (`rg`) — necesario para `live_grep` y `grep_string`.
- **fd** — acelera `find_files` (opcional; si no está, se usa `find`).
- **make** y un compilador de C — necesarios para compilar `fzf-native`.

Los tres están disponibles en este sistema.
