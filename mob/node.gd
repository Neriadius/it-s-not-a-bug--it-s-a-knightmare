extends Node


@export var rogue_scene: PackedScene


func _on_timer_timeout() -> void:
	var play = get_tree().get_current_scene().get_node("Player") as Node2D
	
	var random_direction = Vector2.RIGHT.rotated(randf_range(0, TAU))
	var random_distance = randi_range(700, 970)
	var spawn_enemy = play.global_position + (random_direction * random_distance)
	
	var rogue = rogue_scene.instantiate() as Node2D
	get_parent().add_child(rogue)
	
	rogue.global_position = spawn_enemy
