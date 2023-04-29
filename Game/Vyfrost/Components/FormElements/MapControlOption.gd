@tool
extends HBoxContainer
class_name MapControlOption

# Exports
@export var controlTitle: String
@export var buttonText: String: set = set_button_text
@export var disabled := false: set = set_disabled
@export var action : String: set = set_action
# Signals
signal pressed
signal new_control_mapped(new_control)
signal highlighted
# State
var remapping := false
var just_remapped := false
# References


var icons := {
	'Left click': preload('res://Assets/Sprites/UI/Controls/Left-click Control.png'),
	'Right click': preload('res://Assets/Sprites/UI/Controls/Right-click Control.png'),
	'Scroll': preload('res://Assets/Sprites/UI/Controls/Scroll Control.png'),
	'East controller button': preload('res://Assets/Sprites/UI/Controls/PS Circle, Xbox B, Nintendo A.png'),
	'South controller button': preload('res://Assets/Sprites/UI/Controls/PS Cross, Xbox A, Nintendo B.png'),
}


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$ControlName.text = controlTitle
	$"%ValueButton".text = buttonText
	update_button_text()
	
	# --- CONNECT TO SIGNALS ---
	pass 


func update_button_text() -> void:
	print(InputHelper.get_control_name(action))
	var new_text = InputHelper.get_control_name(action)
	set_button_text(new_text)

func set_disabled(isDisabled: bool) -> void:
	$"%ValueButton".disabled = isDisabled
	disabled = isDisabled

func set_button_text(text: String) -> void:
	$"%ValueButton".text = text

func set_action(new_action: String) -> void:
	action = new_action

func toggle_neighbour_focusable() -> void:
	self.set_focus_neighbor(MARGIN_TOP, ".")
	self.set_focus_neighbor(MARGIN_BOTTOM, ".")
	self.set_focus_neighbor(MARGIN_LEFT, ".")
	self.set_focus_neighbor(MARGIN_RIGHT, ".")

func _input(event: InputEvent) -> void:
	if remapping and \
	not just_remapped and \
	event.is_action_type() and \
	event is InputEvent and \
	not event.is_pressed() and \
	not event.is_echo():
		just_remapped = true
		InputHelper.set_action(action, event)
		if event is InputEventMouseButton:
			set_button_text(InputHelper.get_mouse_button_name(event.button_index))
		else:
			set_button_text(event.as_text())
		end_remapping()

func end_remapping() -> void:
	emit_signal("new_control_mapped")
	remapping = false
	toggle_neighbour_focusable()
	$"%ValueButton".button_pressed = false
	VyfrostGlobal.save_current_keymap()
	await get_tree().create_timer(0.5).timeout
	just_remapped = false


# --- HANDLE SIGNALS ---
func _on_ValueButton_pressed() -> void:
	emit_signal("pressed")
	remapping = true

func _on_ValueButton_focus_entered() -> void:
	emit_signal("highlighted")

func _on_ValueButton_mouse_entered() -> void:
	emit_signal("highlighted")

