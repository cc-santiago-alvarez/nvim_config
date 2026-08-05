return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "folke/neodev.nvim",
    "hrsh7th/nvim-cmp",
    "hrsh7th/cmp-nvim-lsp",
  },
  config = function()
    require("mason").setup()
    require("mason-lspconfig").setup({
      ensure_installed = {
        "lua_ls",
        "html",
        "cssls",
        "tsserver",  -- JavaScript / TypeScript / Node
        "gopls",     -- Go
        "pyright",   -- Python
      }
    })

		 local on_attach = function(_, bufnr)
      local bufopts = { noremap = true, silent = true, buffer = bufnr }
      vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
      vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
      vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
      vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
    end

    -- Capacidades de nvim-cmp para que el autocompletado del LSP funcione
    local capabilities = require("cmp_nvim_lsp").default_capabilities()

		require("neodev").setup()
		require("lspconfig").lua_ls.setup({
			on_attach = on_attach,
			capabilities = capabilities,
			settings = {
				Lua = {
					telemetry = {enable = false},
					workspace  = { checkThirdParty = false }
				}
			}
		})

	-- Configuración del servidor HTML (html)
    -- html y cssls necesitan snippetSupport para autocompletar tags/propiedades
    local web_capabilities = vim.deepcopy(capabilities)
    web_capabilities.textDocument.completion.completionItem.snippetSupport = true

    require("lspconfig").html.setup({
      on_attach = on_attach,
      capabilities = web_capabilities,
    })

    -- Configuración del servidor CSS (cssls)
    require("lspconfig").cssls.setup({
      on_attach = on_attach,
      capabilities = web_capabilities,
    })

    -- Configuración del servidor TypeScript/JavaScript (tsserver)
    require("lspconfig").tsserver.setup({
      on_attach = on_attach,
      capabilities = capabilities,
    })

    -- Configuración del servidor Go (gopls)
    require("lspconfig").gopls.setup({
      on_attach = on_attach,
      capabilities = capabilities,
      settings = {
        gopls = {
          analyses = {
            unusedparams = true,
          },
          staticcheck = true,
        },
      },
    })

    -- Configuración del servidor Python (pyright)
    require("lspconfig").pyright.setup({
      on_attach = on_attach,
      capabilities = capabilities,
      settings = {
        python = {
          analysis = {
            autoSearchPaths = true,
            useLibraryCodeForTypes = true,
            diagnosticMode = "openFilesOnly",
          },
        },
      },
    })
  end
}
