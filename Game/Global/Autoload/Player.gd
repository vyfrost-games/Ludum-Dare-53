extends Node

# Exports

# Signals
signal magic_changed
# State
var max_magic: int = 1000
var current_magic: float = 400 : set = set_magic
var magic_depletion_rate: float = 2

# References



# Called when the node enters the scene tree for the first time.
func _ready() -> void:

	# --- CONNECT TO SIGNALS ---
	Global.new_second.connect(handle_new_second)


func set_magic(new_value: float) -> void:
	current_magic = new_value
	magic_changed.emit()

# --- HANDLE SIGNALS ---
func handle_new_second() -> void:
	current_magic -= magic_depletion_rate

	if current_magic < 0:
		Global.pause()
		Global.pause_movement()
