require("luasnip.loaders.from_snipmate").lazy_load()

local cmp = require "cmp"
local luasnip = require "luasnip"

cmp.setup {
  sources = {
    { name = "luasnip" },
    { name = "nvim_lsp" },
    { name = "nvim_lua" },
    { name = "buffer" },
    { name = "path" },
  },

  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },

  mapping = {
    ["<C-E>"] = cmp.mapping.abort(),
    ["<C-D>"] = cmp.mapping.scroll_docs(4),
    ["<C-U>"] = cmp.mapping.scroll_docs(-4),
    ["<C-N>"] = cmp.mapping.select_next_item(),
    ["<C-P>"] = cmp.mapping.select_prev_item(),
    ["<C-Y>"] = cmp.mapping.confirm(),
    ["<CR>"]  = cmp.mapping.confirm(),

    ["<Tab>"] = function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.jumpable(1) then
        luasnip.jump(1)
      else
        fallback()
      end
    end,

    ["<S-Tab>"] = function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end,
  },
}
