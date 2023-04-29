extends Label
class_name MenuDescription

# Exports

# Signals

# State
var description := {
	# PAUSE
	'resume': 'Keep playing',
	'settings': 'Audio, graphics & more',
	'controls': 'Reassign key bindings',
	'quit': 'Return to title screen',
	# SETTINGS
	'MasterVolume': 'Changes the volume of everything',
	'MusicVolume': 'Change the background music and ambience',
	'SFXVolume': 'Sound effects like harvesting, walking, etc... ',
	'Brightness': 'Adjust brightness',
	'DifficultySelect': 'How hard the gameplay is',
	'LanguageSelect': 'Use a different language',
	'VibrationToggle': 'Controllers, Joypads, etc...',
	'FullscreenToggle': 'Fullscreen works best on a 1920x1080 screen',
	# CONTROLS
	'Primary': 'Digging, sowing & harvesting',
	'Next Item': 'Next inventory item',
	'Last Item': 'Previous inventory item',
	'Left': 'Move left',
	'Right': 'Move right',
	'Up': 'Move up',
	'Down': 'Move down',
}

# References



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	
	# --- CONNECT TO SIGNALS ---
	pass 

func update_description(button_text: String) -> void:
	if button_text in description:
		text = description[button_text]


# --- HANDLE SIGNALS ---
