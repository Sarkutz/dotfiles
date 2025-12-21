local wezterm = require("wezterm")

local base = {}

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
		config.color_scheme = "Gruvbox (Gogh)"
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
	}
end

return base
