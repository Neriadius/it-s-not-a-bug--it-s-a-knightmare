extends Node2D

@onready var health_bar = $CanvasLayer/HP
@onready var play = $Player

func _ready():
	health_bar.max_value = play.max_health

func _on_player_hp_changed(new_health: Variant) -> void:
	health_bar.value = play.health
	
	if play.kill_count >= 10:
		get_tree().change_scene_to_file("res://Levels/load_screen_1.tscn")
