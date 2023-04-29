@tool
extends HBoxContainer
class_name SelectOption

# Exports
@export (String) var title: String
@export (Array) var options: Array
@export (int) var current_index: int

# Signals
signal highlighted
# State

# References



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if title:
		$SelectTitle.text = title
	if options.size() > 0:
		$HBoxContainer/ItemSelected.text = options[current_index]
	
	# --- CONNECT TO SIGNALS ---
	pass 




# --- HANDLE SIGNALS ---
func _on_LeftArrow_pressed() -> void:
	if options.size() > 0:
		if current_index == 0:
			var last_item_index = options.size() - 1
			current_index = last_item_index
			$HBoxContainer/ItemSelected.text = options[current_index]
		else:
			current_index -= 1
			$HBoxContainer/ItemSelected.text = options[current_index]
	else:
		print('No options available for ', title)

func _on_RightArrow_pressed() -> void:
	if options.size() > 0:
		var last_item_index = options.size() - 1
		if current_index == last_item_index:
			current_index = 0
			$HBoxContainer/ItemSelected.text = options[0]
		else:
			current_index += 1 
			$HBoxContainer/ItemSelected.text = options[current_index]
	else:
		print('No options available for ', title)


func _on_LeftArrow_focus_entered() -> void:
	emit_signal('highlighted')

func _on_RightArrow_focus_entered() -> void:
	emit_signal('highlighted')

func _on_LeftArrow_mouse_entered() -> void:
	emit_signal('highlighted')

func _on_RightArrow_mouse_entered() -> void:
	emit_signal('highlighted')
