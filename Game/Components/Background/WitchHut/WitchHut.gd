extends Node2D

# Exports
@export_range(0, 1) var variant: int = 0 : set = set_variant
# Signals

# State

# References


# Called when the node enters the scene tree for the first time.
func _ready():
	set_variant(variant)
	var tween = create_tween()
	tween.tween_property(self, 'position:x', position.x + 100, 12).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_IN_OUT)
	tween.chain().tween_property(self, 'position:x', position.x, 12)
	tween.set_loops()
	# --- CONNECT TO SIGNALS ---
	pass

func set_variant(new_value: int) -> void:
	variant = new_value

	$AnimationPlayer.play("variant_" + str(variant + 1) + "_idle")


# --- HANDLE SIGNALS ---

