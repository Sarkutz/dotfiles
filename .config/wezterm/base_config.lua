local wezterm = require("wezterm")

local base = {}

-- wezterm.gui is not available to the mux server, so take care to
-- do something reasonable when this config is evaluated by the mux
local function get_appearance()
	if wezterm.gui then
		return wezterm.gui.get_appearance()
	end
	return "Gruvbox (Gogh)"
end

local function scheme_for_appearance(appearance)
	if appearance:find("Dark") then
		return "Gruvbox Dark (Gogh)"
	else
		return "Gruvbox (Gogh)"
	end
end

function base.apply_to_config(config)
	-- Appearance
	-- ==========
	config.hide_tab_bar_if_only_one_tab = true
	config.window_padding = {
		left = 0,
		right = 0,
		top = 0,
		bottom = 0,
	}

	-- Font
	-- ====
	local env = os.getenv("WEZTERM_ENV")
	if env ~= "emacs" then
		-- config.color_scheme = "Gruvbox (Gogh)"
		config.color_scheme = scheme_for_appearance(get_appearance())
		config.font = wezterm.font("JetBrains Mono")
		config.font_size = 12
		config.line_height = 1.0
	end

	-- Keybindings
	-- ===========
	-- Modifers: SUPER|CTRL|SHIFT|ALT|LEADER
	config.leader = { key = "w", mods = "CTRL|ALT", timeout_milliseconds = 1000 }
	config.keys = {
		{ key = "l", mods = "LEADER", action = wezterm.action.ShowLauncher },

		-- DISABLE C-w (which closes the pane) so that we can use it in Vim.
		{
			key = "w",
			mods = "CTRL",
			action = wezterm.action.DisableDefaultAssignment,
		},
		{
			key = "w",
			mods = "CTRL|SHIFT",
			action = wezterm.action.DisableDefaultAssignment,
		},
	}
	config.mouse_bindings = {
		-- Disable copy to system clipboard on select
		{
			event = { Up = { streak = 1, button = "Left" } },
			mods = "NONE",
			action = wezterm.action.DisableDefaultAssignment,
		},
		{
			event = { Up = { streak = 2, button = "Left" } },
			mods = "NONE",
			-- action = wezterm.action.Nop,
			action = wezterm.action.DisableDefaultAssignment,
		},
		{
			event = { Up = { streak = 3, button = "Left" } },
			mods = "NONE",
			action = wezterm.action.DisableDefaultAssignment,
		},
		-- Open hyperlinks
		{
			event = { Up = { streak = 1, button = "Left" } },
			mods = "CTRL|ALT",
			action = wezterm.action.OpenLinkAtMouseCursor,
		},
		-- Open hyperlinks: disable 'Down' event to avoid weird program behaviors
		{
			event = { Down = { streak = 1, button = "Left" } },
			mods = "CTRL|ALT",
			action = wezterm.action.Nop,
		},
	}

	-- Selecting Text
	-- config.quick_select_remove_styling = true
	-- regex syntax: https://docs.rs/regex/latest/regex/#syntax
	-- config.quick_select_patterns = { '[0-9a-f]{7,40}' }

	-- hyperlinks
	-- https://wezterm.org/hyperlinks.html#implicit-hyperlinks
end

return base
