extends Node

@onready var players: Node = $Players


func play(sfx: AudioStream, single=false) -> void:
	if not sfx:
		return
		
	if single:
		stop()

	for player in players.get_children():
		if not player.playing:
			player.stream = sfx
			player.play()
			break


func stop() -> void:
	for player in players.get_children():
		player.stop()
