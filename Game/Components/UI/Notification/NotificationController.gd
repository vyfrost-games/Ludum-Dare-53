extends Node2D

# Exports
@export var time_until_new_notification := 10
@export var max_notifications := 2
# Signals

# State
var previous_notifications: = []
var time_passed_since_notification := 0
# References



# Called when the node enters the scene tree for the first time.
func _ready():
#	Global.trigger_next_notification()
	# --- CONNECT TO SIGNALS ---
	Global.new_notification.connect(handle_new_notification)
	Global.notification_removed.connect(handle_notification_removed)
	Global.new_second.connect(handle_new_second)


func get_non_active_notification():
	var children = get_children()
	var notifications_to_choose_from = []
	for child in children:
		if not child.active:
			notifications_to_choose_from.append(child)
	if notifications_to_choose_from.is_empty():
		print('All notifications are active!')
		return null
	else:
		var non_active_notification = notifications_to_choose_from.pop_at(randf_range(0, notifications_to_choose_from.size()))
		return non_active_notification


# --- HANDLE SIGNALS ---
func handle_new_notification(potion_colour: int) -> void:
	print('Handle new notification! | ', potion_colour)
	var non_active_notification = get_non_active_notification()
	if not non_active_notification == null:
		non_active_notification.potion_colour = potion_colour
		non_active_notification.active = true


func handle_notification_removed() -> void:
	time_passed_since_notification = 0
	await get_tree().create_timer(2).timeout
	Global.trigger_next_notification()

func handle_new_second() -> void:
	print(Global.notifications)
	time_passed_since_notification += 1
	if time_passed_since_notification >= time_until_new_notification \
	and not Global.notifications.size() >= max_notifications:
		Global.trigger_next_notification()
