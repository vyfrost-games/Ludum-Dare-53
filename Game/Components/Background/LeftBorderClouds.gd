extends Node2D

# Exports

# Signals

# State

# References



# Called when the node enters the scene tree for the first time.
func _ready():
	var tween = create_tween()
	tween.tween_property(self, 'position:x', position.x + 20, 12).set_ease(Tween.EASE_IN_OUT)
	tween.chain().tween_property(self, 'position:x', position.x, 12)
	tween.set_loops()

	# --- CONNECT TO SIGNALS ---
	pass




# --- HANDLE SIGNALS ---

