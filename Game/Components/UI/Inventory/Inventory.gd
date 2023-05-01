extends Node2D

# Exports

# Signals

# State

# References
var potion_textures:= [
	preload("res://Assets/Sprites/UI/Potions/Cyan_potion__small_pixel.png"),
	preload("res://Assets/Sprites/UI/Potions/Pink_potion_pixel.png")
]


# Called when the node enters the scene tree for the first time.
func _ready():


	# --- CONNECT TO SIGNALS ---
	Player.add_potion.connect(handle_add_potion)
	Player.remove_potion.connect(handle_remove_potion)





# --- HANDLE SIGNALS ---
func handle_add_potion(potion_colour: int) -> void:
	print('show potion')
	$Potion1.texture = potion_textures[Player.current_inventory[0]]
	$AnimationPlayer.play_backwards("1=>0")

func handle_remove_potion(potion_colour:int) -> void:
	$AnimationPlayer.play("1=>0")
