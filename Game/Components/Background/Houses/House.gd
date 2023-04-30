@tool
extends Sprite2D
class_name House

# Exports
@export var houseTextures := [
	preload("res://Assets/Sprites/Background/Houses/House 1/House_1_pixel.png"),
	preload("res://Assets/Sprites/Background/Houses/House 1/House_1_v2_pixel.png"),
	preload("res://Assets/Sprites/Background/Houses/House 1/House_1_v3_pixel.png"),
	preload("res://Assets/Sprites/Background/Houses/House 1/House_1_v4_pixel.png"),
	]
var silhouetteTextures := [
	preload("res://Assets/Sprites/Background/Houses/House 1/House_1_silhouette_pixel.png"),
	preload("res://Assets/Sprites/Background/Houses/House 1/House_1_v2_silhouette_pixel.png"),
	preload("res://Assets/Sprites/Background/Houses/House 1/House_1_v3_silhouette_pixel.png"),
	preload("res://Assets/Sprites/Background/Houses/House 1/House_1_v4_solhouette_pixel.png")
]
@export_range(0, 3) var house_texture_index : int = 0 : set = set_house_texture_index
@export var silhouette := false : set = set_silhouette
# Signals

# State
# References



# Called when the node enters the scene tree for the first time.
func _ready():
	reset_house()
	# --- CONNECT TO SIGNALS ---
	pass


func set_house_texture_index(new_index: int) -> void:
	house_texture_index = new_index
	reset_house()

func reset_house() -> void:
	if silhouette:
		texture = silhouetteTextures[house_texture_index]
		scale = Vector2(0.8, 0.8)
	else:
		texture = houseTextures[house_texture_index]
		scale = Vector2(1, 1)

func set_silhouette(new_value: bool) -> void:
	silhouette = new_value
	reset_house()
