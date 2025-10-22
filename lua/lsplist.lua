local servers = {
    clangd = {
        cmd = { "clangd", "--background-index", "--clang-tidy" },
        filetypes = { "c", "cpp", "objc", "objcpp", "cuda" },
        root_markers = { "compile_commands.json", ".clangd", ".git" },
    },
    ["rust-analyzer"] = {
        cmd = { "rust-analyzer" },
        filetypes = { "rust" },
        root_markers = { "Cargo.toml", "rust-project.json", ".git" },
        settings = {
            ["rust-analyzer"] = {
                cargo = { allFeatures = true },
                check = { command = "clippy" },
            },
        },
    },
    zls = {
        cmd = { "zls" },
        filetypes = { "zig", "zir" },
        root_markers = { "build.zig", "zls.json", ".git" },
    },
}

return servers
