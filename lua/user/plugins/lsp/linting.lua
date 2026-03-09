return {
	"nvimtools/none-ls.nvim",
    dependencies = {
        -- NOTE: Some Formatters and Linters Might Require a Pull From This Plugin
        "nvimtools/none-ls-extras.nvim", -- Needed for eslint_d
    },
	config = function()
		local null_ls = require("null-ls")

        -- Pull eslint_d from extras
        local eslint_d_diagnostics = require("none-ls.diagnostics.eslint_d")
        local eslint_d_actions     = require("none-ls.code_actions.eslint_d")

		null_ls.setup({
			sources = {
                -- Lua formatting (complement to conform.nvim)
				null_ls.builtins.formatting.stylua,

                -- JavaScript/TypeScript linting via eslint_d
                eslint_d_diagnostics,
                eslint_d_actions,

                -- NOTE: Python formatting (black, isort) is handled by conform.nvim
                -- NOTE: JS/TS/CSS/HTML formatting (prettier) is handled by conform.nvim
			},
		})

		-- Keymap
		vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, {}) -- Format Current Buffer
	end,
}
