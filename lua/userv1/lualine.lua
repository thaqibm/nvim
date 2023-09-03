local status_ok, lualine = pcall(require, "lualine")
if not status_ok then
	return
end
local hide_in_width = function()
	return vim.fn.winwidth(0) > 80
end

-- TODO: Not hardcode values for fg, bg
-- local bg = vim.api.nvim_get_hl_by_name("TabLine", true).bg
vim.api.nvim_set_hl(0, 'lualinered', { fg = "#bd2c00", bg = "#252525", bold = true} )
vim.api.nvim_set_hl(0, 'lualineyellow', { fg = "#F59E0A", bg = "#252525", bold = true})
vim.api.nvim_set_hl(0, 'lualinegreen', { fg = "#6cc644", bg = "#252525", bold = true})

local diagnostics = {
	"diagnostics",
	sources = { "nvim_diagnostic" },
	sections = { "error", "warn" },
	symbols = { error = " ", warn = " " },
	colored = false,
	update_in_insert = false,
	always_visible = true,
}

local diff = {
	"diff",
	colored = false,
	symbols = { added = "%#lualinegreen#+ ", modified = "%#lualineyellow# ", removed = "%#lualinered#- " }, -- changes diff symbols
  cond = hide_in_width
}

local mode = {
	"mode",
	fmt = function(str)
		return "-- " .. str .. " --"
	end,
}

local filetype = {
	"filetype",
	icons_enabled = true
}

local branch = {
	"branch",
	icons_enabled = true,
	icon = "",
}

local location = {
	"location",
	padding = 0,
}
local spaces = function()
	return "spaces: " .. vim.api.nvim_buf_get_option(0, "shiftwidth")
end

lualine.setup({
	options = {
		icons_enabled = true,
		theme = "auto",
		always_divide_middle = true,
	},
	sections = {
		lualine_a = { branch, diagnostics },
		lualine_b = { mode },
		lualine_c = {},
		-- lualine_x = { "encoding", "fileformat", "filetype" },
		lualine_x = { diff, spaces, "encoding", filetype },
		lualine_y = { location },
		lualine_z = { progress },
	},
	inactive_sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = { "filename" },
		lualine_x = { "location" },
		lualine_y = {},
		lualine_z = {},
	},
	tabline = {},
	extensions = {},
})
-- lualine.setup()

