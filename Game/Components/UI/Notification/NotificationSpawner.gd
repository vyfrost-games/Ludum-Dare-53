extends Node2D

# Exports
@export var current_notifications : int = 0 : set = set_current_notifications
@export var space_between_notifications: int = 0
# Signals

# State

# References



# Called when the node enters the scene tree for the first time.
func _ready():


	# --- CONNECT TO SIGNALS ---
	Global.new_notification.connect(handle_new_notification)

#
func add_notification() -> NotificationBubble:
	var notification_bubble = NotificationBubble.new()
	if not Engine.is_editor_hint():
		Global.notifications.append(notification_bubble)
	add_child(notification_bubble)
	return notification_bubble

func remove_notification() -> void:
	if not Engine.is_editor_hint():
		var newest_notification : NotificationBubble = Global.notifications.pop_front()
		remove_child(newest_notification)


func set_current_notifications(new_value: int) -> void:
	if current_notifications > new_value:
		remove_notification()
	elif current_notifications < new_value:
		add_notification()
	current_notifications = new_value



# --- HANDLE SIGNALS ---
func handle_new_notification(potion_colour: String) -> void:
	var new_notification = add_notification()

