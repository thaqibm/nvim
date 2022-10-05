local status_ok, bufferline = pcall(require, "bufferline")
if not status_ok then
    return
end

vim.opt.termguicolors = true
bufferline.setup{
    highlights = {

        buffer_selected = {
            bold = true,
            italic = false,
        },
    }
}


