extends Node2D

# Exports

# Signals

# State

# References



# Called when the node enters the scene tree for the first time.
func _ready():
	Global.play()
	Global.trigger_next_notification()
	Global.play_music.emit('Main')
	# --- CONNECT TO SIGNALS ---
	pass




# --- HANDLE SIGNALS ---

