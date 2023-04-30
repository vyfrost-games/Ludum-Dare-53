extends Node2D
class_name NotificationBubble

# Exports

# Signals

# State
var highlighted := false
# References
var highlight_notification_sprite := preload("res://Assets/Sprites/UI/Notification/Notification_bubble_highlight.png")
var notification_sprite := preload("res://Assets/Sprites/UI/Notification/Notification_bubble.png")

# Called when the node enters the scene tree for the first time.
func _ready():


	# --- CONNECT TO SIGNALS ---
	pass




# --- HANDLE SIGNALS ---
func _on_area_2d_body_entered(body):
	if body.get_class() == 'CharacterBody2D':
		print('Witch!')
		$Bg.texture = highlight_notification_sprite


func _on_area_2d_body_exited(body):
	if body.get_class() == 'CharacterBody2D':
		print('Witch exited')
		$Bg.texture = notification_sprite

#func _on_area_2d_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
#	print(body)


#func _on_area_2d_body_shape_exited(body_rid, body, body_shape_index, local_shape_index):
#	print(body)
