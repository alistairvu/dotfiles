return {
	{
		"nvimtools/none-ls.nvim",
		opts = function(_, opts)
			local null_ls = require("null-ls")
			opts.sources = vim.list_extend(opts.sources or {}, {
				null_ls.builtins.formatting.stylua,
        null_ls.builtins.diagnostics.fish,
        null_ls.builtins.diagnostics.clazy,
        null_ls.builtins.formatting.clang_format,

        null_ls.builtins.formatting.black,
        null_ls.builtins.formatting.isort,
			})
		end,

		config = function()
			vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, {})
		end,
	},
}
