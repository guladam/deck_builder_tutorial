extends CanvasLayer

@onready var color_rect: ColorRect = $ColorRect
@onready var timer: Timer = $Timer


func _ready() -> void:
	Events.player_hit.connect(_on_player_hit)
	timer.timeout.connect(_on_timer_timeout)


func _on_player_hit() -> void:
	color_rect.color.a = 0.2
	timer.start()


func _on_timer_timeout() -> void:
	color_rect.color.a = 0.0
