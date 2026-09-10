-- Parsers a instalar. La rama `main` de nvim-treesitter no tiene
-- `ensure_installed`: se instalan llamando a `install()` en el config.
local languages = {
  "lua",
  "luadoc",
  "vim",
  "vimdoc",
  "regex",
  "html",
  "css",
  "javascript",
  "typescript",
  "tsx",
  "json",
  "go",
  "gomod",
  "gosum",
  "python",
  "bash",
  "yaml",
  "markdown",
  "markdown_inline",
}

return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    -- La rama `main` no soporta lazy-loading.
    lazy = false,
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter").install(languages)

      -- El highlight y el indent ya no los activa el plugin: hay que
      -- encenderlos por buffer. El highlight lo aporta Neovim
      -- (vim.treesitter.start), el indentexpr lo aporta nvim-treesitter.
      vim.api.nvim_create_autocmd("FileType", {
        group = vim.api.nvim_create_augroup("treesitter_enable", { clear = true }),
        callback = function(args)
          local lang = vim.treesitter.language.get_lang(args.match)
          if not lang then
            return
          end
          -- Falla si el parser aún no está instalado; no es un error.
          if not pcall(vim.treesitter.start, args.buf, lang) then
            return
          end
          vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end,
      })
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    branch = "main",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    event = "VeryLazy",
    config = function()
      require("nvim-treesitter-textobjects").setup({
        select = {
          lookahead = true,
        },
      })

      local select = require("nvim-treesitter-textobjects.select")
      local objects = {
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@conditional.outer",
        ["ic"] = "@conditional.inner",
        ["al"] = "@loop.outer",
        ["il"] = "@loop.inner",
      }

      for lhs, query in pairs(objects) do
        vim.keymap.set({ "x", "o" }, lhs, function()
          select.select_textobject(query, "textobjects")
        end, { desc = "Textobject " .. query })
      end
    end,
  },
}
