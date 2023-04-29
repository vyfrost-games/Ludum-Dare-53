extends Control

# Exports

# Signals
signal option_selected(option_name)

# State
var current_focus: String

# References
@onready var button_container: VBoxContainer = $"%ButtonContainer"
@onready var menu_description: MenuDescription = $"%MenuDescription"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	focus_first_menu_button()
	link_button_focus_signals()

	# --- CONNECT TO SIGNALS ---
	pass

func focus_first_menu_button() -> void:
	var first_button: PauseMenuButton = button_container.get_child(0)
	first_button.grab_focus()

func handle_pause_menu_button_focus(button_text: String) -> void:
	current_focus = button_text
	menu_description.update_description(button_text)

func handle_pause_menu_button_pressed(button_text: String) -> void:
	emit_signal("option_selected", button_text)

# --- HANDLE SIGNALS ---
func link_button_focus_signals() -> void:
	for child in button_container.get_children():
		var pause_menu_button: PauseMenuButton = child
		pause_menu_button.connect("focus_entered", Callable(self, 'handle_pause_menu_button_focus').bind(pause_menu_button.text))
		pause_menu_button.connect("pressed", Callable(self, 'handle_pause_menu_button_pressed').bind(pause_menu_button.text))

