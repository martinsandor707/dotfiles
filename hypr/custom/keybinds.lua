-- This file will not be overwritten across dots-hyprland updates.
-- The file name is for the sake of organization and does not matter
-- See the corresponding files in ~/.config/hypr/hyprland for examples
hl.bind("SUPER + F1", hl.dsp.global("quickshell:cheatsheetToggle"), { description = "Shell: Toggle cheatsheet" })
hl.bind("ALT + F5", hl.dsp.exec_cmd("brightnessctl -d intel_backlight set 5%-"), { description = "Increase brightness" })
hl.bind("ALT + F6", hl.dsp.exec_cmd("brightnessctl -d intel_backlight set +5%"), { description = "Decrease brightness" })