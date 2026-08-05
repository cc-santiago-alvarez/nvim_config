return {
  {
    'nvim-lua/plenary.nvim'
  },
  {
    'hrsh7th/nvim-cmp',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-cmdline',
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip',
      'onsails/lspkind-nvim',
      'windwp/nvim-autopairs',
      'petertriho/cmp-git',
    },
    config = function()
      local cmp = require('cmp')
      local lspkind = require('lspkind')
      local cmp_autopairs = require('nvim-autopairs.completion.cmp')

      require('cmp_git').setup()

      cmp.setup({
        snippet = {
          expand = function(args)
            require('luasnip').lsp_expand(args.body)
          end,
        },
        formatting = {
          format = lspkind.cmp_format({
            with_text = true,
            maxwidth = 50,
            menu = {
              buffer = "[Buf]",
              nvim_lsp = "[LSP]",
              path = "[Path]",
              luasnip = "[Snip]",
              git = "[Git]",
            },
          }),
        },
        mapping = cmp.mapping.preset.insert({
          ['<C-d>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<C-e>'] = cmp.mapping.abort(),
          ['<CR>'] = cmp.mapping.confirm({ select = true }),
        }),
        sources = cmp.config.sources({
          { name = 'nvim_lsp' },
          { name = 'luasnip' },
          { name = 'git' },
        }, {
          { name = 'buffer' },
          { name = 'path' },
        }),
      })

      cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done { map_char = { tex = "" }})

      cmp.setup.cmdline('/', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = 'buffer' }
        }
      })

      cmp.setup.cmdline(':', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = 'path' }
        }, {
          { name = 'cmdline' }
        }),
      })

      -- Los servidores LSP (y sus capabilities) se configuran en plugins/lsp.lua

      require('nvim-autopairs').setup({
        check_ts = true,
      })
    end
  },
}

