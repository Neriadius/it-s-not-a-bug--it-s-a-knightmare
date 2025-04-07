extends Node2D

@onready var load = $TextureProgressBar

func _on_timer_timeout() -> void:
	for i in 101:
		load.value = i
		await get_tree().create_timer(0.01).timeout
	if load.value == 100:
		get_tree().change_scene_to_file("res://Menus/true_menu.tscn")
