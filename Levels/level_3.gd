extends Node2D

@onready var play = $Player

func _process(delta: float) -> void:
	if play.kill_count >= 10000:
		get_tree().change_scene_to_file("res://Levels/load_screen_3.tscn")
