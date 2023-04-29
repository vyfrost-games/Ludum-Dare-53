extends Control

# Exports

# Signals

# State

# References
@onready var texture_progress_bar = $TextureProgressBar



# Called when the node enters the scene tree for the first time.
func _ready():


	# --- CONNECT TO SIGNALS ---
	pass

func change_progress_amount(new_percentage: float) -> int:
	if new_percentage < 0 or new_percentage > 100 : return ERR_INVALID_PARAMETER
	var max_value := 90
	var adjusted_percentage := new_percentage * (max_value/100)
	texture_progress_bar.value = adjusted_percentage
	return OK


# --- HANDLE SIGNALS ---

