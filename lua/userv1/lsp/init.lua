local status_ok, _ = pcall(require, "lspconfig")
if not status_ok then
    return
end

require("userv1.lsp.lsp-installer")
require("userv1.lsp.handlers").setup()
