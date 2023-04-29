extends Button
class_name PauseMenuButton

# Exports

# Signals

# State

# References
var default_font := preload('res://Vyfrost/Assets/Font/RedHatMono/MenuFont_default.tres')
var bold_font := preload('res://Vyfrost/Assets/Font/RedHatMono/MenuFont_bold.tres')


# Called when the node enters the scene tree for the first time.
func _ready() -> void:

	# --- CONNECT TO SIGNALS ---
	pass


# --- HANDLE SIGNALS ---
func _on_MenuButton_focus_entered() -> void:
	Audio.play_sfx('VyHover')
	add_theme_font_override("font", bold_font)

func _on_MenuButton_focus_exited() -> void:
	add_theme_font_override("font", default_font)

func _on_MenuButton_mouse_entered() -> void:
	grab_focus()
