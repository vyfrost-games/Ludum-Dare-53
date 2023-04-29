@tool
extends HBoxContainer
class_name ToggleOption

# Exports
@export var text: String
@export var value: bool: set = set_value
# Signals
signal toggled(isOn)
signal highlighted
# State

# References



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Label.text = text
	
	# --- CONNECT TO SIGNALS ---
	pass 

func set_value(isOn: bool) -> void:
	value = isOn
	if isOn:
		$ON.show()
		$OFF.hide()
	else:
		$OFF.show()
		$ON.hide()


# --- HANDLE SIGNALS ---
func _on_ON_pressed() -> void:
	Trigger.sfx('VySelect')
	set_value(false)
	emit_signal("toggled", value)


func _on_OFF_pressed() -> void:
	Trigger.sfx('VySelect')
	set_value(true)
	emit_signal("toggled", value)


func _on_OFF_focus_entered() -> void:
	emit_signal('highlighted')

func _on_OFF_mouse_entered() -> void:
	emit_signal('highlighted')

func _on_ON_focus_entered() -> void:
	emit_signal('highlighted')

func _on_ON_mouse_entered() -> void:
	emit_signal('highlighted')
