extends Node


func play(audio: AudioStream, single=false) -> void:
	if not audio:
		return
		
	if single:
		stop()

	for player in get_children():
		player = player as AudioStreamPlayer
		
		if not player.playing:
			player.stream = audio
			player.play()
			break


func stop() -> void:
	for player in get_children():
		player = player as AudioStreamPlayer
		player.stop()
