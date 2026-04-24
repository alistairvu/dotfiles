return {
  "neovim/nvim-lspconfig",
  setup = {
    basedpyright = function(_, opts)
      require("lspconfig").basedbyright.setup()
      return true
    end,
    ["*"] = function(server,opts) end,
  },
}
