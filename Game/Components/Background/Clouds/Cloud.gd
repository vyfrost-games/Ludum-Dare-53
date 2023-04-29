@tool
extends Sprite2D

# Exports
@export var clouds := [
	load("res://Assets/Sprites/Background/Clouds/Cloud_1_pixel.png"),
	load("res://Assets/Sprites/Background/Clouds/Cloud_2_pixel.png"),
	load("res://Assets/Sprites/Background/Clouds/Cloud_3_pixel.png"),
	load("res://Assets/Sprites/Background/Clouds/Cloud_4_pixel.png"),
	load("res://Assets/Sprites/Background/Clouds/Cloud_5_pixel.png"),
	load("res://Assets/Sprites/Background/Clouds/Cloud_6_pixel.png"),
	load("res://Assets/Sprites/Background/Clouds/Cloud_7_pixel.png"),
	load("res://Assets/Sprites/Background/Clouds/Cloud_8_pixel.png"),
	]
@export_range(0, 7) var cloud_texture_index : int = 0
# Signals

# State
var current_cloud_index = cloud_texture_index
# References



# Called when the node enters the scene tree for the first time.
func _ready():
	texture = clouds[cloud_texture_index]
	# --- CONNECT TO SIGNALS ---
	pass

func _process(delta: float) -> void:
	# Editor only
	if Engine.is_editor_hint():
		if current_cloud_index != cloud_texture_index:
			texture = clouds[cloud_texture_index]
			current_cloud_index = cloud_texture_index



# --- HANDLE SIGNALS ---

