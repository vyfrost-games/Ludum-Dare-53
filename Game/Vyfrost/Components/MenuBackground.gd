@tool
extends Control

# Exports
@export var horizontal_glow_margin: int: set = set_horizontal_glow_margin
@export var vertical_glow_margin: int: set = set_vertical_glow_margin

# Signals

# State

# References



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Horizontal margin
	var avg_horizontal_glow_margin = int(float($MarginContainer.offset_left + $MarginContainer.offset_right) / 2)
	set_horizontal_glow_margin(avg_horizontal_glow_margin)
	# Vertical margin
	var avg_vertical_glow_margin = int(float($MarginContainer.offset_top + $MarginContainer.offset_bottom) / 2)
	set_vertical_glow_margin(avg_vertical_glow_margin)

	# --- CONNECT TO SIGNALS ---
	pass

func set_horizontal_glow_margin(new_glow_margin: int) -> void:
	horizontal_glow_margin = new_glow_margin
	$MarginContainer.offset_left = new_glow_margin
	$MarginContainer.offset_right = new_glow_margin


func set_vertical_glow_margin(new_glow_margin: int) -> void:
	vertical_glow_margin = new_glow_margin
	$MarginContainer.offset_top = new_glow_margin
	$MarginContainer.offset_bottom = new_glow_margin
# --- HANDLE SIGNALS ---
