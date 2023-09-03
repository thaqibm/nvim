local status_ok, mason = pcall(require, "mason")
if not status_ok then
	return
end
local status_ok, mason_lspconfig = pcall(require, "mason-lspconfig")
if not status_ok then
	return
end

local status_ok, lspconfig = pcall(require, "lspconfig")
if not status_ok then
    return
end


mason.setup({
    ui = {
        icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗"
        }
    }
})
mason_lspconfig.setup{}

mason_lspconfig.setup_handlers {
    function(server)
        local opts = {
            on_attach = require("userv1.lsp.handlers").on_attach,
            capabilities = require("userv1.lsp.handlers").capabilities,
        }

        if server == "jsonls" then
            local jsonls_opts = require("userv1.lsp.settings.jsonls")
            opts = vim.tbl_deep_extend("force", jsonls_opts, opts)
        end

        if server == "sumneko_lua" then
            local sumneko_opts = require("userv1.lsp.settings.sumneko_lua")
            opts = vim.tbl_deep_extend("force", sumneko_opts, opts)
        end

        if server == "pyright" then
            local pyright_opts = require("userv1.lsp.settings.pyright")
            opts = vim.tbl_deep_extend("force", pyright_opts, opts)
        end

        lspconfig[server].setup(opts)
    end
}
