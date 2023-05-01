extends Node

# Exports

# Signals
signal magic_changed
signal add_potion(potion_colour: int)
signal remove_potion(potion_colour: int)
# State
var max_magic: float = 1000
var current_magic: float = 500 : set = set_magic
var magic_depletion_rate: float = 10
# Inventory State
var current_inventory: Array[int] = []
var POTION_COLOURS = Global.POTION_COLOURS
var potion_magic := {
	POTION_COLOURS.BLUE: {
		'sell': 200,
		'buy': 100
	},
	POTION_COLOURS.PINK: {
		'sell': 300,
		'buy': 150
	},
	POTION_COLOURS.GREEN: {
		'sell': 400,
		'buy': 200
	},
}
# References



# Called when the node enters the scene tree for the first time.
func _ready() -> void:

	# --- CONNECT TO SIGNALS ---
	Global.new_second.connect(handle_new_second)

func sell_potion(potion_colour: int) -> int:
	if potion_colour in current_inventory:
		# Remove from inventory
		var index = current_inventory.find(potion_colour)
		current_inventory.remove_at(index)
		# Update everything else
		remove_potion.emit(potion_colour)
		current_magic += potion_magic[potion_colour].sell
		Global.play_sfx.emit('UI_GetPaidB', 0)
		return OK
	else:
		print('No Potion in inventory! Inventory: ', current_inventory)
		Global.play_sfx.emit('UI_Error')
		return ERR_DOES_NOT_EXIST


func buy_potion(potion_colour: int) -> int:
	if current_inventory.is_empty():
		if not potion_colour in current_inventory and current_magic > potion_magic[potion_colour].buy + 10:
			current_inventory.append(potion_colour)
			add_potion.emit(potion_colour)
			current_magic -= potion_magic[potion_colour].buy
			Global.play_sfx.emit('UI_BuyPotionB')
			return OK
		else:
			print('Can\'t buy potion...')
			return ERR_FILE_MISSING_DEPENDENCIES
	else:
		print('Potion already equipped, swapping potion')
		var current_potion = current_inventory.pop_at(0)
		remove_potion.emit(current_potion)
		buy_potion(potion_colour)
		return OK

func set_magic(new_value: float) -> void:
	current_magic = new_value
	magic_changed.emit()

#func set_inventory(new_value) -> void:
#	print(new_value)
#	var previous_inventory = current_inventory
#	current_inventory = new_value
#	if previous_inventory.size() > new_value.size():
#		print('Add potion')
#		add_potion.emit()
#	elif previous_inventory.size() < new_value.size():
#		print('Remove potion')
#		remove_potion.emit()


# --- HANDLE SIGNALS ---
func handle_new_second() -> void:
	current_magic -= magic_depletion_rate

	if current_magic < 0:
		Global.pause()
		Global.pause_movement()
