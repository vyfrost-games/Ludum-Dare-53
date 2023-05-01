extends Node2D
class_name NotificationBubble

# Exports
@export var total_time_per_request := 10
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
var progress_colour := Color.GREEN
var previous_sfx := {}
# References
var highlight_notification_sprite := preload("res://Assets/Sprites/UI/Notification/Notification_bubble_highlight.png")
var notification_sprite := preload("res://Assets/Sprites/UI/Notification/Notification_bubble.png")
var progress_bar_tween: Tween
var request_audio := {
	'UI_Request1': preload("res://Assets/Audio/UI_Request1.wav"),
	'UI_Request2': preload("res://Assets/Audio/UI_Request2.wav"),
	'UI_Request3': preload("res://Assets/Audio/UI_Request3.wav"),
	'UI_Request4': preload("res://Assets/Audio/UI_Request4.wav"),
	'UI_Request5': preload("res://Assets/Audio/UI_Request5.wav"),
	'UI_Request6': preload("res://Assets/Audio/UI_Request6.wav"),
	'UI_Request7': preload("res://Assets/Audio/UI_Request7.wav"),
}

# Called when the node enters the scene tree for the first time.
func _ready():
	$ProgressBar.modulate = progress_colour
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
			else:
				error_animation()
			await get_tree().create_timer(0.5).timeout
			just_triggered = false
		if event.is_action("interact") and active and highlighted:
			var result = Player.sell_potion(potion_colour)
			if result == OK:
				active = false
			else:
				error_animation()

			await get_tree().create_timer(0.5).timeout
			just_triggered = false
	return

func set_active(new_value: bool) -> void:
	active = new_value
	if active:
		Global.notifications.append(self)
		show()
		var tween = create_tween()
		tween.tween_property(self, 'modulate:a', 1, 1)
		start_progress()
#		play_request_sound()
	else:
		var index = Global.notifications.find(self)
		if index >= 0:
			Global.notifications.remove_at(index)
		var tween = create_tween()
		tween.tween_property(self, 'modulate:a', 0, 1)
		if progress_bar_tween:
			progress_bar_tween.kill()

func play_request_sound():
	play_rand_sfx('UI_Request', 7, $AudioStreamPlayer2D, 0.0)

func play_rand_sfx(title: String, variations: int, player: AudioStreamPlayer2D, volume_db: float) -> void:
	randomize()
	var rand: int = floor(randf_range(1,variations + 0.9))

	# Prevent repeating the same sfx
	if not title in previous_sfx:
		previous_sfx[title] = []

	if rand in previous_sfx[title]:
		for _n in range(5):
			rand = floor(randf_range(1,variations + 0.9))

			if not rand in previous_sfx:
				break

	player.stop()
	player.stream = request_audio[title+str(rand)]
	player.volume_db = volume_db
	player.play()

	# Prevent last two SFX playing
	previous_sfx[title].push_front(rand)
	if previous_sfx[title].size() >= 3:
		previous_sfx[title].pop_back()

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
	progress_colour = Color.GREEN
	$ProgressBar.modulate = Color.GREEN
	progress_bar_tween.tween_property($ProgressBar, 'value', 0, total_time_per_request)

func set_potion_colour(new_value:int)->void:
	potion_colour = new_value
	$Potion.texture = potion_sprites[potion_colour]

func error_animation():
	var tween = create_tween()
	tween.tween_property(self, 'rotation', deg_to_rad(15), 0.1).set_trans(Tween.TRANS_CIRC).set_ease(Tween.EASE_IN_OUT)
	tween.chain().tween_property(self, 'rotation', deg_to_rad(-15), 0.1)
	tween.chain().tween_property(self, 'rotation', 0, 0.1)
	var colour_tween := create_tween()
	colour_tween.tween_property(self, 'modulate', Color.INDIAN_RED, 0.3)
	colour_tween.chain().tween_property(self, 'modulate', Color.WHITE, 0.3)


# --- HANDLE SIGNALS ---
func handle_remove_potion(_potion_sold_colour: int):
	print('Removed potion | Current Inventory: ', Player.current_inventory)
	if buy_potion and not Player.current_inventory.has(potion_colour):
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
		tween.tween_property($ProgressBar, 'modulate', Color.RED, 0.5)
	elif value <= 66:
		var tween = create_tween()
		tween.tween_property($ProgressBar, 'modulate', Color.ORANGE, 0.5)
