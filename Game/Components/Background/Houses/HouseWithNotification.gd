extends Node2D
class_name HouseWithNotification

# Exports
#@export var houseTextures := [
#	preload("res://Assets/Sprites/Background/Houses/House 1/House_1_pixel.png"),
#	preload("res://Assets/Sprites/Background/Houses/House 1/House_1_v2_pixel.png"),
#	preload("res://Assets/Sprites/Background/Houses/House 1/House_1_v3_pixel.png"),
#	preload("res://Assets/Sprites/Background/Houses/House 1/House_1_v4_pixel.png"),
#	]
#@export_range(0, 3) var house_texture_index : int = 0 : set = set_house_texture_index
#@export var silhouette := false : set = set_silhouette

# Signals

# State
# References
#@onready var house = $House
#@onready var notification = $Notification




# Called when the node enters the scene tree for the first time.
func _ready():
	# --- CONNECT TO SIGNALS ---
	pass

func set_house_texture_index(new_value: int) -> void:
	house_texture_index = new_value
	if $House:
		$House.house_texture_index = house_texture_index
		print($House)

func set_silhouette(new_value: bool) -> void:
	silhouette = new_value
	if $House:
		$House.silhouette = silhouette



# --- HANDLE SIGNALS ---

