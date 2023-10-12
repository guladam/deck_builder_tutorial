extends Node

@onready var players: Node = $Players


func play(audio: AudioStream, single=false) -> void:
	if not audio:
		return
		
	if single:
		stop()

	for player in players.get_children():
		if not player.playing:
			player.stream = audio
			player.play()
			break


func stop() -> void:
	for player in players.get_children():
		player.stop()
