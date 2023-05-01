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
	'StartFlying1': preload("res://Assets/Audio/Player_StartFlying1.wav"),
	'StartFlying2':preload("res://Assets/Audio/Player_StartFlying2.wav"),
	'StartFlying3':preload("res://Assets/Audio/Player_StartFlying3.wav"),
	'StartFlying4': preload("res://Assets/Audio/Player_StartFlying4.wav"),
	'StartFlying5':preload("res://Assets/Audio/Player_StartFlying5.wav"),
	'StartFlying6':preload("res://Assets/Audio/Player_StartFlying6.wav"),
	'StartFlying7':preload("res://Assets/Audio/Player_StartFlying7.wav"),
	'UI_Error': preload("res://Assets/Audio/UI_Error.wav"),
	'UI_GetPaidA1': preload("res://Assets/Audio/UI_GetPaidA1.wav"),
	'UI_GetPaidA2':preload("res://Assets/Audio/UI_GetPaidA2.wav"),
	'UI_GetPaidA3':preload("res://Assets/Audio/UI_GetPaidA3.wav"),
	'UI_GetPaidA4': preload("res://Assets/Audio/UI_GetPaidA4.wav"),
	'UI_GetPaidB1': preload("res://Assets/Audio/UI_GetPaidB1.wav"),
	'UI_GetPaidB2':preload("res://Assets/Audio/UI_GetPaidB2.wav"),
	'UI_GetPaidB3': preload("res://Assets/Audio/UI_GetPaidB3.wav"),
	'UI_GetPaidB4':preload("res://Assets/Audio/UI_GetPaidB4.wav"),
	'UI_BuyPotionA1':preload("res://Assets/Audio/UI_BuyPotionA1.wav"),
	'UI_BuyPotionA2':preload("res://Assets/Audio/UI_BuyPotionA2.wav"),
	'UI_BuyPotionA3':preload("res://Assets/Audio/UI_BuyPotionA3.wav"),
	'UI_BuyPotionA4': preload("res://Assets/Audio/UI_BuyPotionA4.wav"),
	'UI_BuyPotionB1':preload("res://Assets/Audio/UI_BuyPotionB1.wav"),
	'UI_BuyPotionB2':preload("res://Assets/Audio/UI_BuyPotionB2.wav"),
	'UI_BuyPotionB3':preload("res://Assets/Audio/UI_BuyPotionB3.wav"),
	'UI_BuyPotionB4':preload("res://Assets/Audio/UI_BuyPotionB4.wav"),
	'UI_BroomDie':preload("res://Assets/Audio/UI_BroomDie.wav"),
	'UI_Select': preload("res://Assets/Audio/UI_Select.wav"),
	'UI_Win': preload("res://Assets/Audio/UI_Win.wav"),
	'UI_Request1': preload("res://Assets/Audio/UI_Request1.wav"),
	'UI_Request2': preload("res://Assets/Audio/UI_Request2.wav"),
	'UI_Request3': preload("res://Assets/Audio/UI_Request3.wav"),
	'UI_Request4': preload("res://Assets/Audio/UI_Request4.wav"),
	'UI_Request5': preload("res://Assets/Audio/UI_Request5.wav"),
	'UI_Request6': preload("res://Assets/Audio/UI_Request6.wav"),
	'UI_Request7': preload("res://Assets/Audio/UI_Request7.wav"),
}
# References


func _ready() -> void:
#	load_all_sfx()
	Global.play_game.connect(handle_play)
	Global.pause_game.connect(handle_pause)
	Global.play_music.connect(handle_music)
	Global.play_sfx.connect(handle_sfx)
#
#func load_all_sfx():
#	print(DirAccess.get_files_at("res://Assets/Audio/"))
#	for file in DirAccess.get_files_at("res://Assets/Audio/"):
#		if file.ends_with('.wav'):
#			var file_name_segments := file.split('_')
#			file_name_segments.remove_at(0)
#			file_name_segments.join().split().remove_at(file_name_segments.size() - 1)
#			var file_name := file
#

func handle_sfx(sfx_title: String, volume_db: float = 0.0):
	play_sfx(sfx_title, volume_db)

func play_sfx(sfx_title: String, volume_db: float = 0.0) -> void:

#	var player = AudioStreamPlayer.new()
#	add_child(player)
	var player = $SFXPlayer
	match sfx_title:
		'StartFlying':
			play_rand_sfx(sfx_title, 7, player, volume_db)
		'UI_GetPaidA':
			play_rand_sfx(sfx_title, 4, player, volume_db)
		'UI_GetPaidB':
			play_rand_sfx(sfx_title, 4, player, volume_db)
		'UI_BuyPotionA':
			play_rand_sfx(sfx_title, 4, player, volume_db)
		'UI_BuyPotionB':
			play_rand_sfx(sfx_title, 4, player, volume_db)
		'UI_Error':
			print('Trigger SFX!!!!!!')
			play_normal_sfx(sfx_title, player, volume_db)
		'UI_BroomDie':
			play_normal_sfx(sfx_title, player, volume_db)
		'UI_Select':
			play_normal_sfx(sfx_title, player, volume_db)
		'UI_Win':
			play_normal_sfx(sfx_title, player, volume_db)
		'VySelect':
			play_rand_sfx(sfx_title, 3, player, volume_db)
		'VyCancel':
			play_rand_sfx(sfx_title, 3, player, volume_db)
		'VyHover':
			play_rand_sfx(sfx_title, 4, player, volume_db)
		'Pause':
			play_rand_sfx(sfx_title, 1, player, volume_db)
		'Unpause':
			play_rand_sfx(sfx_title, 1, player, volume_db)

func play_normal_sfx(sfx_title: String, player: AudioStreamPlayer, volume_db: float):
	if sfx_title in all_sfx:
		player.stream = all_sfx[sfx_title]
		player.volume_db = volume_db
		player.play()

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

#	await player.finished
#	player.queue_free()


### MUSIC ###

var music = {
	'Main': preload("res://Assets/Audio/Music_WitchLvl_1.0.wav"),
	'Menu': preload("res://Assets/Audio/Music_MainMenu_1.0.wav")
}

func transition_to(stream: AudioStream) -> void:
	var tween = create_tween()
	tween.tween_property($MusicPlayer, 'volume_db', -80, 1)
	await tween.finished
	$MusicPlayer.stop()
	$MusicPlayer.stream = stream
	$MusicPlayer.play()
	tween.tween_property($MusicPlayer, 'volume_db', 0, 1)

func handle_music(track_title: String) -> void:
	if $MusicPlayer.playing:
		transition_to(music[track_title])
	else:
		$MusicPlayer.stream = music[track_title]
		$MusicPlayer.play()

func handle_ending(_win_or_gameover: String) -> void:
#	transition_to(music.MenuMusic)
	pass

#func handle_tutorial(tutorial_on: bool) -> void:
#	if tutorial_on:
#		transition_to(music.MenuMusic)
#	else:
#		$MusicPlayer.stream = music.JamTheme
#		$MusicPlayer.play()

func handle_pause() -> void:
	var fade_music_effect := AudioEffectLowPassFilter.new()
	fade_music_effect.cutoff_hz = 1000

	AudioServer.add_bus_effect(1, fade_music_effect)
#
#
func handle_play() -> void:
	if not AudioServer.get_bus_effect_count(1) == 0:
		AudioServer.remove_bus_effect(1, 0)

# --- HANDLE SIGNALS ---

