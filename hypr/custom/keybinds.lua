-- This file will not be overwritten across dots-hyprland updates.
-- The file name is for the sake of organization and does not matter
-- See the corresponding files in ~/.config/hypr/hyprland for examples
hl.bind("SUPER + F1", hl.dsp.global("quickshell:cheatsheetToggle"), { description = "Shell: Toggle cheatsheet" })
hl.bind(
	"ALT + F5",
	hl.dsp.exec_cmd("brightnessctl -d intel_backlight set 5%-"),
	{ description = "Martin custom: Increase brightness" }
)
hl.bind(
	"ALT + F6",
	hl.dsp.exec_cmd("brightnessctl -d intel_backlight set +5%"),
	{ description = "Martin custom: Decrease brightness" }
)
-- Toggle University VPN via openconnect runner
hl.bind(
	"SUPER + CTRL + SHIFT + C",
	hl.dsp.exec_cmd(os.getenv("HOME") .. "/.config/hypr/scripts/vpn-toggle.sh"),
	{ description = "Martin custom: Toggle University OpenConnect VPN" }
)

-- Reset Wirepipe Audio
hl.bind(
	"SUPER + CTRL + SHIFT + A",
	hl.dsp.exec_cmd("~/.config/hypr/scripts/restart-audio.sh"),
	{ description = "Martin custom: Reset Wirepipe Audio" }
)
