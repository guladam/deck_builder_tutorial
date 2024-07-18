extends EventRoom

@onready var fifty_button: EventRoomButton = %FiftyButton
@onready var thirty_button: EventRoomButton = %ThirtyButton
@onready var skip_button: EventRoomButton = %SkipButton


func setup() -> void:
	skip_button.visible = run_stats.gold < 50
	fifty_button.disabled = run_stats.gold < 50
	thirty_button.disabled = run_stats.gold < 50
	
	fifty_button.event_button_callback = bet_50
	thirty_button.event_button_callback = bet_30


func bet_30() -> void:
	thirty_button.disabled = true
	run_stats.gold -= 50
	
	if RNG.instance.randf() < 0.3:
		run_stats.gold += 200


func bet_50() -> void:
	fifty_button.disabled = true
	run_stats.gold -= 50
	
	if RNG.instance.randf() < 0.5:
		run_stats.gold += 100
