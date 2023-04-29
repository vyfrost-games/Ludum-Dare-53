extends Node

# Exports
# Signals
signal resume
signal pause
# State
var vyfrost_data: Dictionary
# References
var vyfrost_data_folder_path := 'res://Vyfrost/Assets/Resources'
var vyfrost_data_resource_path := 'res://Vyfrost/Assets/Resources/VyfrostData.tres'

# Define the path to the folder and resource file where the Vyfrost data will be stored
#var vyfrost_data_folder_path := 'user://Player/Vyfrost'
#var vyfrost_data_resource_path := 'user://Player/Vyfrost/VyfrostData.tres'

# Load the Vyfrost data from the resource file or create new data if it doesn't exist

func _ready() -> void:
	vyfrost_data = get_vyfrost_data().data
	load_keymap()

# --- CRUD DATA ---
# Function to load the Vyfrost data from the resource file or create new data if it doesn't exist
func get_vyfrost_data() -> VyfrostData:
	var loaded_vyfrost_data: VyfrostData = null
	if ResourceLoader.exists(vyfrost_data_resource_path):
		loaded_vyfrost_data = load(vyfrost_data_resource_path)

	if OS.has_feature("standalone") or loaded_vyfrost_data:
		return loaded_vyfrost_data
	else:
		# Create new Vyfrost Data
		return new_vyfrost_data()

# Function to create new Vyfrost data
func new_vyfrost_data() -> VyfrostData:
	var new_data = VyfrostData.new()

	# If the data folder already exists, save the new data to the resource file
	if DirAccess.dir_exists_absolute(vyfrost_data_folder_path):
		ResourceSaver.save(new_data, vyfrost_data_resource_path,)
		return new_data
	else:
		# If the data folder doesn't exist, create it and save the new data to the resource file
		DirAccess.make_dir_absolute(vyfrost_data_folder_path)
		ResourceSaver.save(new_data, vyfrost_data_resource_path)
		return new_data

# Function to save the Vyfrost data to the resource file
func save_vyfrost_data() -> void:
	var loaded_vyfrost_data: VyfrostData = get_vyfrost_data()
	if vyfrost_data: loaded_vyfrost_data.data = vyfrost_data
	ResourceSaver.save(loaded_vyfrost_data, vyfrost_data_resource_path)


# --- PAUSE MENU ---
func show_pause_menu() -> void:
	emit_signal("pause")

func hide_pause_menu() -> void:
	emit_signal("resume")


## --- PERSIST REMAPPED CONTROLS ---
func get_current_keymap() -> Dictionary:
	var current_keymap := {}
	for action in InputMap.get_actions():
		if InputMap.action_get_events(action).size() > 0:
			current_keymap[action] = InputMap.action_get_events(action)[0]
	return current_keymap

func save_current_keymap() -> void:
	vyfrost_data.controls = get_current_keymap()
	save_vyfrost_data()

func load_keymap() -> void:
	var current_keymap := get_current_keymap()
	# Set loaded keymaps
	var player_keymap : Dictionary = vyfrost_data.controls
	for action in player_keymap.keys():
		if player_keymap.has(action):
			current_keymap[action] = player_keymap[action]
			# Whilst setting the keymap dictionary, we also set the
			# correct InputMap event
			InputMap.action_erase_events(action)
			InputMap.action_add_event(action, current_keymap[action])


# --- VOLUME ---
# Function to change the volume of a sound bus
#func change_volume(bus_name: String, value: int) -> void:
#	# TODO: implement volume change logic here
#	pass
