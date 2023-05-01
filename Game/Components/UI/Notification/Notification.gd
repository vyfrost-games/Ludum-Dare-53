extends Node2D
class_name NotificationBubble

# Exports
@export var total_time_per_request := 60
@export var buy_potion := false : set = set_buy_potion
@export_enum('Blue', 'Pink', 'Green') var colour : int
var potion_colour : int = 0 : set = set_potion_colour
var active := false : set = set_active
# Signals

# State
var highlighted := false
var potion_sprites := [
	preload("res://Assets/Sprites/UI/Potions/Cyan_potion__small_pixel.png"),
	preload("res://Assets/Sprites/UI/Potions/Pink_potion_pixel.png")
]
var sparkle_sprites := [
	preload("res://Assets/Sprites/UI/Notification/sparkles_green.png"),
	preload("res://Assets/Sprites/UI/Notification/sparkles_red.png")
]
var just_triggered := false
# References
var highlight_notification_sprite := preload("res://Assets/Sprites/UI/Notification/Notification_bubble_highlight.png")
var notification_sprite := preload("res://Assets/Sprites/UI/Notification/Notification_bubble.png")
var progress_bar_tween: Tween

# Called when the node enters the scene tree for the first time.
func _ready():
	potion_colour = colour
	if not buy_potion:
		hide()
		active = false
	var tween = create_tween()
	tween.tween_property(self, 'position:y', 10, 1.2).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_IN_OUT)
	tween.chain().tween_property(self, 'position:y', 0, 1.2)
	tween.set_loops()
	# --- CONNECT TO SIGNALS ---
	Player.remove_potion.connect(handle_remove_potion)

func _input(event: InputEvent) -> void:
	if not event.is_echo() and not just_triggered:
		if buy_potion and event.is_action("interact") and highlighted:
			just_triggered = true
			var result = Player.buy_potion(potion_colour)
			if result == OK:
				create_tween().tween_property(self, 'modulate:a', 0, 1)

			await get_tree().create_timer(0.5).timeout
			just_triggered = false
		if event.is_action("interact") and active and highlighted:
			var result = Player.sell_potion(potion_colour)
			if result == OK:
				active = false
	return

func set_active(new_value: bool) -> void:
	active = new_value
	if active:
		Global.notifications.append(self)
		show()
		var tween = create_tween()
		tween.tween_property(self, 'modulate:a', 1, 1)
		start_progress()
	else:
		var index = Global.notifications.find(self)
		if index >= 0:
			Global.notifications.remove_at(index)
		var tween = create_tween()
		tween.tween_property(self, 'modulate:a', 0, 1)
		if progress_bar_tween:
			progress_bar_tween.kill()

func set_buy_potion(new_value: bool):
	buy_potion = new_value
	if buy_potion:
		$Sparkles.texture = sparkle_sprites[1]
		$ProgressBar.hide()
	else:
		$Sparkles.texture = sparkle_sprites[0]

func start_progress():
	progress_bar_tween = create_tween()
	$ProgressBar.value = 100
	progress_bar_tween.tween_property($ProgressBar, 'value', 0, total_time_per_request)

func set_potion_colour(new_value:int)->void:
	potion_colour = new_value
	$Potion.texture = potion_sprites[potion_colour]

# --- HANDLE SIGNALS ---
func handle_remove_potion(potion_sold_colour: int):
	if buy_potion and potion_sold_colour == potion_colour:
		create_tween().tween_property(self, 'modulate:a', 1, 1)

func _on_area_2d_body_entered(body):
	if body.get_class() == 'CharacterBody2D':
		$Bg.texture = highlight_notification_sprite
		highlighted = true


func _on_area_2d_body_exited(body):
	if body.get_class() == 'CharacterBody2D':
		$Bg.texture = notification_sprite
		highlighted = false


func _on_progress_bar_value_changed(value: float):
	if value <= 0:
		Global.remove_notification(self)
		active = false
	elif value <= 33:
		var tween = create_tween()
		tween.tween_property($ProgressBar, 'modulate', Color.DARK_RED, 0.5)
	elif value <= 66:
		var tween = create_tween()
		tween.tween_property($ProgressBar, 'modulate', Color.DARK_GOLDENROD, 0.5)
