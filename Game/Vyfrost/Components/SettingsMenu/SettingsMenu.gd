extends Control

# Exports

# Signals
signal return_to_pause_menu

# State
var being_updated := false

# References
@onready var options_container: VBoxContainer = $"%OptionsContainer"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$"%FullscreenToggle".set_value(((get_window().mode == Window.MODE_EXCLUSIVE_FULLSCREEN) or (get_window().mode == Window.MODE_FULLSCREEN)))

	# --- CONNECT TO SIGNALS ---
	connect_signals()
#	$"%MasterVolume".connect("drag_started", self, 'handle_drag_started', ['MasterVolume'])
#	$"%MasterVolume".connect("drag_ended", self, 'handle_drag_ended', ['MasterVolume'])
#	$"%MusicVolume".connect("drag_started", self, 'handle_drag_started', ['MusicVolume'])
#	$"%MusicVolume".connect("drag_ended", self, 'handle_drag_ended', ['MusicVolume'])
#	$"%SFXVolume".connect("drag_started", self, 'handle_drag_started', ['SFXVolume'])
#	$"%SFXVolume".connect("drag_ended", self, 'handle_drag_ended', ['SFXVolume'])
#	$"%Brightness".connect("drag_started", self, 'handle_drag_started', ['Brightness'])
#	$"%Brightness".connect("drag_ended", self, 'handle_drag_ended', ['Brightness'])


func get_all_controls() -> Array:
	var sliders: Array = $"%SliderContainer".get_children()
#	var selects: Array = $"%SelectContainer".get_children()
	var toggles: Array = $"%ToggleContainer/MarginContainer".get_children()

	var allControls = sliders + toggles
	return allControls

func connect_signals() -> void:
	for control in get_all_controls():
		control.connect("highlighted", Callable(self, 'handle_focus').bind(control.name))

	var sliders: Array = $"%SliderContainer".get_children()
	for slider in sliders:
		slider.connect("drag_started", Callable(self, 'handle_drag_started').bind(slider.name))
		slider.connect("drag_ended", Callable(self, 'handle_drag_ended').bind(slider.name))


func handle_drag_started(node_name: String) -> void:
	being_updated = true
	dim_all_options_except(node_name)

func dim_all_options_except(node_name: String) -> void:
	for node in options_container.get_children():
		if node_name != node.name:
			var tween = get_tree().create_tween()
			tween.tween_property(node, 'modulate:a', 0.3, 0.2)

	# Fade out Back button
	var tween = get_tree().create_tween()
	tween.tween_property($BackButton, 'modulate:a', 0.5, 0.2)
	await get_tree().create_timer(0.2).timeout
	$BackButton.disabled = true
	$BackButton.modulate.a = 1.0


func undim_all_options() -> void:
	for node in options_container.get_children():
		var tween = get_tree().create_tween()
		tween.tween_property(node, 'modulate:a', 1.0, 0.2)
	# Fade in Back button
	var tween = get_tree().create_tween()
	$BackButton.disabled = false
	tween.tween_property($BackButton, 'modulate:a', 1.0, 0.2)


func handle_drag_ended(new_value: int, value_changed: bool, slider_name: String) -> void:
	being_updated = false
	undim_all_options()
	# Set new value
	if value_changed:
		match slider_name:
			'MasterVolume':
				AudioServer.set_bus_volume_db(0, linear_to_db(float(new_value)/100))
			'MusicVolume':
				AudioServer.set_bus_volume_db(1, linear_to_db(float(new_value)/100))
			'SFXVolume':
				AudioServer.set_bus_volume_db(2, linear_to_db(float(new_value)/100))
			'Brightness':
				pass



func handle_focus(title: String) -> void:
	if not being_updated:
		$"%MenuDescription".update_description(title)

# --- HANDLE SIGNALS ---
func _on_BackButton_pressed() -> void:
	Audio.play_sfx("VyCancel")
	emit_signal("return_to_pause_menu")


func _on_FullscreenToggle_toggled(isOn: bool) -> void:
	print('Fullscreen toggled!', ((get_window().mode == Window.MODE_EXCLUSIVE_FULLSCREEN) or (get_window().mode == Window.MODE_FULLSCREEN)))
	get_window().mode = Window.MODE_EXCLUSIVE_FULLSCREEN if (isOn) else Window.MODE_WINDOWED
