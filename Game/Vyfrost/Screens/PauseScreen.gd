extends CanvasLayer

# Exports

# Signals

# State

# References



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hide()

	# --- CONNECT TO SIGNALS ---
	VyfrostGlobal.connect("show_pause_menu", Callable(self, 'handle_show_pause_menu'))
	VyfrostGlobal.connect("hide_pause_menu", Callable(self, 'handle_hide_pause_menu'))


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel", false):
		if not Global.paused:
			Global.pause()
			Global.pause_movement()
			VyfrostGlobal.show_pause_menu()
		else:
			Global.play()
			Global.play_movement()
			VyfrostGlobal.hide_pause_menu()

func hide_all_menus() -> void:
	for child in $Backdrop.get_children():
		child.hide()

# --- HANDLE SIGNALS ---
func handle_show_pause_menu() -> void:
	show()

func handle_hide_pause_menu() -> void:
	hide()
	hide_all_menus()
	$Backdrop/PauseMenu.show()


func _on_PauseMenu_option_selected(option_name: String) -> void:
	match option_name:
		'resume':
			VyfrostGlobal.hide_pause_menu()
			Audio.play_sfx('Unpause')
			Global.play()
			await get_tree().create_timer(0.4).timeout
			Global.play_movement()
		'settings':
			Audio.sfx('VyCancel')
			hide_all_menus()
			$Backdrop/SettingsMenu.show()
		'controls':
			Audio.sfx('VyCancel')
			hide_all_menus()
			$Backdrop/ControlsMenu.show()
		'quit':
			get_tree().quit()
		_:
			Audio.sfx('VySelect')

func _on_SettingsMenu_return_to_pause_menu() -> void:
	hide_all_menus()
	$Backdrop/PauseMenu.show()

func _on_ControlsMenu_return_to_pause_menu() -> void:
	hide_all_menus()
	$Backdrop/PauseMenu.show()
