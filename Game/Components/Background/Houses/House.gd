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
var silhoutteTextures := [
	preload("res://Assets/Sprites/Background/Houses/House 1/House_1_silhouette_pixel.png"),
	preload("res://Assets/Sprites/Background/Houses/House 1/House_1_v2_silhouette_pixel.png"),
	preload("res://Assets/Sprites/Background/Houses/House 1/House_1_v3_silhouette_pixel.png"),
	preload("res://Assets/Sprites/Background/Houses/House 1/House_1_v4_solhouette_pixel.png")
]
@export_range(0, 3) var house_texture_index : int = 0 : set = set_house_texture_index
@export var silhouette := false
# Signals

# State
var current_silhouette := silhouette
# References



# Called when the node enters the scene tree for the first time.
func _ready():
	set_house_texture_index(house_texture_index)
	# --- CONNECT TO SIGNALS ---
	pass


func set_house_texture_index(new_index: int) -> void:
	house_texture_index = new_index
	if silhouette:
		texture = silhoutteTextures[house_texture_index]
		scale = Vector2(0.8, 0.8)
	else:
		texture = houseTextures[house_texture_index]
		scale = Vector2(1, 1)
