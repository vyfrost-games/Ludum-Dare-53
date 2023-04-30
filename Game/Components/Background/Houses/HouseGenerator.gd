@tool
extends Node2D

# Exports
@export var silhouette := false : set = set_silhouette
@export var total_houses := 0 : set = set_total_houses
@export var house_variations : Array[int] = [0, 0, 0, 0] : set = set_house_variations
@export var space_before_next_house : int = 200 : set = set_space_before_next_house

# Signals

# State

# References


# Called when the node enters the scene tree for the first time.
func _ready():
	add_all_houses()
	# --- CONNECT TO SIGNALS ---
#	Global.new_notification.connect(handle_new_notification)


func add_house(house_index: int) -> House:
	var new_house = House.new()
	new_house.silhouette = silhouette
	new_house.house_texture_index = house_index
	add_child(new_house, true)
	return new_house

func add_all_houses() -> void:
	for n in range(total_houses):
		var house = add_house((n % house_variations.size()) - 1)
		house.position.x += space_before_next_house * n

func get_random_house_variation() -> int:
	return int(randf_range(0, house_variations.size() - 1))

func set_silhouette(new_value: bool) -> void:
	silhouette = new_value
	reset_houses()

func set_total_houses(new_value: int) -> void:
	total_houses = new_value
	reset_houses()

func reset_houses() -> void:
	# Reset houses
	for child in get_children():
		remove_child(child)
	add_all_houses()

func set_space_before_next_house(new_value: int) -> void:
	space_before_next_house = new_value
	reset_houses()

func set_house_variations(new_value: Array[int]) -> void:
	house_variations = new_value
#	var house_containers: Array[Node] = get_children()
#	for n in house_variations.size():
#		var house : Node2D = house_containers[n][]
#		house.house_texture_index = house_variations[n - 1]

###########################


# --- HANDLE SIGNALS ---
#func handle_new_notification(potion_colour: String) -> void:
#	print('New notification! | ', potion_colour)
