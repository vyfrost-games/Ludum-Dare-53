@tool
extends Node

# Exports

# Signals
signal return_to_pause_menu
# State
var action_name := ''
var remapping := false
# References
@onready var options_container := $"%OptionContainer"
@onready var menu_description : MenuDescription = $"%MenuDescription"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# --- CONNECT TO SIGNALS ---
	connect_signals()

func get_all_controls() -> Array:
	var actions: Array = $OptionContainer/ActionControls.get_children()
	var verticalDirections: Array = $OptionContainer/DirectionsContainer/VerticalDirections.get_children()
	var horizontalDirections: Array = $OptionContainer/DirectionsContainer/HorizontalDirections.get_children()
	
	var allControls = actions + verticalDirections + horizontalDirections
	return allControls

func connect_signals() -> void:
	for control in get_all_controls():
		var pause_menu_button: MapControlOption = control
		pause_menu_button.connect("highlighted", Callable(self, 'handle_menu_button_focus').bind(pause_menu_button.controlTitle))
		pause_menu_button.connect("pressed", Callable(self, 'handle_control_pressed').bind(pause_menu_button))
		pause_menu_button.connect("new_control_mapped", Callable(self, 'handle_new_control_mapped'))

func handle_menu_button_focus(title: String) -> void:
	if not remapping:
		menu_description.update_description(title)

# Begin remapping
func handle_control_pressed(node: Node) -> void:
	dim_all_options_except(node)
	remapping = true

# End remapping
func handle_new_control_mapped() -> void:
	undim_all_options()
	remapping = false

func dim_all_options_except(control_being_remapped: MapControlOption) -> void:
	for control in get_all_controls():
		if control_being_remapped != control:
			var tween = get_tree().create_tween()
			tween.tween_property(control, 'modulate:a', 0.3, 0.2)
			control.set_disabled(true)
	
	# Fade out Back button
	var tween = get_tree().create_tween()
	tween.tween_property($BackButton, 'modulate:a', 0.5, 0.2)
	await get_tree().create_timer(0.2).timeout
	$BackButton.disabled = true
	$BackButton.modulate.a = 1.0


func undim_all_options() -> void:
	for control in get_all_controls():
		var map_control_option : MapControlOption = control
		var tween = get_tree().create_tween()
		tween.tween_property(map_control_option, 'modulate:a', 1.0, 0.2)
		map_control_option.set_disabled(false)
		map_control_option.update_button_text()
	# Fade in Back button
	var tween = get_tree().create_tween()
	$BackButton.disabled = false
	tween.tween_property($BackButton, 'modulate:a', 1.0, 0.2)


# --- HANDLE SIGNALS ---
func _on_BackButton_pressed() -> void:
	Trigger.sfx("VyCancel")
	emit_signal("return_to_pause_menu")
