extends CanvasLayer

#var tutorial = preload("res://Scenes/Locations/Jam/Tutorial/Tutorial.tscn")
var world := preload("res://Screens/World.tscn")
#var main_menu = preload("res://Scenes/MainMenu/MainMenu.tscn")


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var scene_to_skip_to := world
	if OS.has_feature('standalone'):
		$AnimationPlayer.play("glitch-in-vyfrost")
		await $AnimationPlayer.animation_finished
	else:
		scene_to_skip_to = world
	get_tree().change_scene_to_packed(scene_to_skip_to)
	queue_free()
