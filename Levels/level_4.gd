extends Node2D

@onready var play = $Player

func _process(delta: float) -> void:
	if play.kill_count >= 10000:
		get_tree().quit()
