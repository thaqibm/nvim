local handler = require("plugins.lsp.handler")

local configured = false

local function get_servers()
    local user_servers = vim.g.lsp_servers
    if type(user_servers) ~= "table" then
        return {}
    end

    if vim.tbl_islist(user_servers) then
        local servers = {}
        for _, name in ipairs(user_servers) do
            servers[name] = {}
        end
        return servers
    end

    return vim.deepcopy(user_servers)
end

local function setup_servers()
    if configured then
        return
    end
    configured = true

    handler.setup()

    local function with_defaults(server_opts)
        server_opts = vim.deepcopy(server_opts or {})

        -- Merge capabilities so per-server overrides can extend them.
        if server_opts.capabilities then
            server_opts.capabilities = vim.tbl_deep_extend(
                "force",
                {},
                handler.capabilities,
                server_opts.capabilities
            )
        else
            server_opts.capabilities = handler.capabilities
        end

        local user_on_attach = server_opts.on_attach
        if user_on_attach then
            server_opts.on_attach = function(client, bufnr)
                handler.on_attach(client, bufnr)
                user_on_attach(client, bufnr)
            end
        else
            server_opts.on_attach = handler.on_attach
        end

        return server_opts
    end

    local servers = get_servers()
    local enabled = {}

    if vim.tbl_isempty(servers) then
        vim.notify("[lsp] No LSP servers configured (vim.g.lsp_servers).", vim.log.levels.INFO)
        return
    end

    for name, server_opts in pairs(servers) do
        vim.lsp.config(name, with_defaults(server_opts))
        local resolved = vim.lsp.config[name]
        local cmd = resolved and resolved.cmd

        local should_enable = true
        if type(cmd) == "table" and cmd[1] ~= nil then
            if vim.fn.executable(cmd[1]) == 0 then
                should_enable = false
                vim.notify(
                    string.format("[lsp] Skipping %s, command %q not found.", name, cmd[1]),
                    vim.log.levels.WARN
                )
            end
        end

        if should_enable then
            table.insert(enabled, name)
        end
    end

    if #enabled > 0 then
        vim.lsp.enable(enabled)
    end
end

return {
    {
        "neovim/nvim-lspconfig",
        event = "VeryLazy",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
        },
        config = setup_servers,
    },
}
