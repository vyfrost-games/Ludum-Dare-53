extends Node

# Exports

# Signals

# State
var previous_sfx := {
#	'Dirt': [],
#	'Grass': [],
#	'Gravel': [],
}
var all_sfx := {
#	'sfxName': load('res://Assets/Audio/sfxName.ogg')
}
# References


func _ready() -> void:
	pass


func play_sfx(sfx_title: String, volume_db: float = 0.0) -> void:

	match sfx_title:
		'VySelect':
			play_rand_sfx(sfx_title, 3, $UIPlayer, volume_db)
		'VyCancel':
			play_rand_sfx(sfx_title, 3, $ActionPlayer, volume_db)
		'VyHover':
			play_rand_sfx(sfx_title, 4, $ActionPlayer, volume_db)
		'Pause':
			play_rand_sfx(sfx_title, 1, $ActionPlayer, volume_db)
		'Unpause':
			play_rand_sfx(sfx_title, 1, $ActionPlayer, volume_db)


func play_rand_sfx(title: String, variations: int, player: AudioStreamPlayer, volume_db: float) -> void:
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
	player.stream = all_sfx[title+str(rand)]
	player.volume_db = volume_db
	player.play()

	# Prevent last two SFX playing
	previous_sfx[title].push_front(rand)
	if previous_sfx[title].size() >= 3:
		previous_sfx[title].pop_back()

# --- HANDLE SIGNALS ---

