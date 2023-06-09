extends Node

# Exports

### Signals ###
# Pause
signal pause_game
signal pause_game_movement
signal play_game
signal play_game_movement
# Time
signal new_second
signal restart
# Notifications
signal new_notification(potion: int)
signal notification_removed
signal notification_error(message: String)
# Audio
signal play_sfx(track_title: String, volume_db: float)
signal play_music(track_title: String)
### State ###
# Time
var paused := true
var paused_movement := false
var previous_game_second: int # Track total seconds played
var game_second: float = 0 # Raw seconds (not rounded)
var total_seconds_played: int = 0 : get = get_time # Clean
# Notifications
var notifications : Array[NotificationBubble] = []
var potion_history : Array[int] = []
enum POTION_COLOURS {
	BLUE,
	PINK,
	GREEN
}
# References



# Called when the node enters the scene tree for the first time.
func _ready():


	# --- CONNECT TO SIGNALS ---
	pass


func _process(delta: float) -> void:
	if not paused:
		# Start time
		game_second += 1 * delta
		# Update every second
		if round(game_second) != previous_game_second:
			secondly_update()

# --- PAUSE ---
func pause() -> void:
	paused = true
	emit_signal("pause_game")

func pause_movement() -> void:
	paused_movement = true
	emit_signal("pause_game_movement")

func play_movement() -> void:
	paused_movement = false
	emit_signal("play_game_movement")

func play() -> void:
	paused = false
	emit_signal("play_game")

# --- TIME UPDATES ---
func secondly_update():
	total_seconds_played += 1
	previous_game_second = round(game_second) # Keep loop going
	new_second.emit()
	gametime_log() # See game running

func get_time() -> int:
	return total_seconds_played

func gametime_log():
	print(round(total_seconds_played), ' sec played | ', Player.current_magic, ' magic left')

func handle_restart() -> void:
	play()

# --- NOTIFICATIONS ---
func trigger_next_notification() -> void:
	add_notification(int(randf_range(0, 2)))


func add_notification(potion_colour: int) -> void:
	new_notification.emit(potion_colour)

func remove_notification(notification_bubble: NotificationBubble) -> void:
	var notification_index := notifications.find(notification_bubble)
	notifications.remove_at(notification_index)
	notification_removed.emit()

# --- HANDLE SIGNALS ---

