extends Node

# Exports

# Signals

# State
var max_magic: int = 1000
var current_magic: float = 200
var magic_depletion_rate: float = 1

# References



# Called when the node enters the scene tree for the first time.
func _ready() -> void:

	# --- CONNECT TO SIGNALS ---
	Global.new_second.connect(handle_new_second)

func _process(delta: float) -> void:
#	print(delta)
	pass

# --- HANDLE SIGNALS ---
func handle_new_second() -> void:
	current_magic -= magic_depletion_rate
	if current_magic < 0:
		Global.pause()
		Global.pause_movement()
