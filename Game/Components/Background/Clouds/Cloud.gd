extends Sprite2D

# Exports
var clouds := [
	preload("res://Assets/Sprites/Background/Clouds/Little_clouds_1.png"),
	preload("res://Assets/Sprites/Background/Clouds/Little_clouds_2.png"),
	preload("res://Assets/Sprites/Background/Clouds/Little_clouds_3.png"),
	preload("res://Assets/Sprites/Background/Clouds/Little_clouds_4.png"),
	preload("res://Assets/Sprites/Background/Clouds/Little_clouds_5.png"),
	preload("res://Assets/Sprites/Background/Clouds/Little_clouds_6.png"),
	preload("res://Assets/Sprites/Background/Clouds/Little_clouds_7.png")
	]
@export_range(0, 6) var cloud_texture_index : int = 0
# Signals

# State
var current_cloud_index = cloud_texture_index
# References



# Called when the node enters the scene tree for the first time.
func _ready():
	texture = clouds[cloud_texture_index]
	var tween = create_tween()
	tween.tween_property(self, 'position:x', position.x + 100, 12).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_IN_OUT)
	tween.chain().tween_property(self, 'position:x', position.x, 12)
	tween.set_loops()

	# --- CONNECT TO SIGNALS ---
	pass

func _process(_delta: float) -> void:
	# Editor only
	if Engine.is_editor_hint():
		if current_cloud_index != cloud_texture_index:
			texture = clouds[cloud_texture_index]
			current_cloud_index = cloud_texture_index



# --- HANDLE SIGNALS ---

