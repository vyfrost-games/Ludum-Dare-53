@tool
extends HBoxContainer
class_name SliderOption


# Exports
@export var text: String
@export var initial_value: int
# Signals
signal drag_started
signal drag_ended(new_value, value_changed)
signal highlighted
# State
var default_sfx := 'ShopPurchase'
# References



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Label.text = text
	$VBoxContainer/HSlider.value = initial_value
	# --- CONNECT TO SIGNALS ---
	pass




# --- HANDLE SIGNALS ---
func _on_HSlider_drag_started() -> void:
	emit_signal("drag_started")


func _on_HSlider_drag_ended(value_changed: bool) -> void:
	emit_signal("drag_ended", $VBoxContainer/HSlider.value, value_changed)
	match text:
		'SFX Volume':
			Audio.play_sfx(default_sfx)



func _on_HSlider_focus_entered() -> void:
	emit_signal("highlighted")

func _on_HSlider_mouse_entered() -> void:
	emit_signal("highlighted")
