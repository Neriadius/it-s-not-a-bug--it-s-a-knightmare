extends Node2D

@onready var anima = $AnimatedSprite2D

func _ready():
	anima.play("idle")
	await anima.animation_finished 
	anima.play("default")
	await anima.animation_finished 
	get_tree().change_scene_to_file("res://Levels/load_screen_2.tscn")
