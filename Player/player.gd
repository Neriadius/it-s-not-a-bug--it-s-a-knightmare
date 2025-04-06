extends CharacterBody2D

var SPEED = 300.0
var max_health = 300
var health
var damage = 20
var shield = 0
var long_glitch = false
var glitch = false
var attacking = false
var move_input = Vector2()
var kill_count

signal HP_changed(new_health) 

@onready var anima = $CollisionShape2D/AnimatedSprite2D
@onready var anim = $AnimationPlayer

func _ready():
	kill_count = 0
	health = max_health
	Signals.connect("enemy_attack", Callable(self, "_on_damage_received"))
	#Signals.connect("player_attack", Callable(self, "_on_damage_received"))

func _process(delta):
	var movement = movement_vector()
	velocity = movement.normalized() * SPEED

	play_animation()
	
	if velocity.x < 0:
		$CollisionShape2D/AnimatedSprite2D.flip_h = true
	elif velocity.x > 0:
		$CollisionShape2D/AnimatedSprite2D.flip_h = false
	
#	$CollisionShape2D/AnimatedSprite2D.flip_h = (velocity.x < 0)

	if health <= 0:
		die()
		return

	move_and_slide()

func play_animation():
	if health <= 0:
		anima.play("Death")
		return
		
	if Input.get_action_strength("attack"):
		if glitch or long_glitch:
			anima.play("glitch_Attack")
		else:
			anim.play("attack")
		return
	
	if velocity.length() > 0:
		if glitch or long_glitch:
			anima.play("glitch_Run")
		else:
			anima.play("Run")
	else:
		if glitch or long_glitch:
			anima.play("glitch_Idle")
		else:
			anima.play("Idle")

func movement_vector():
	# Объединяем ввод с клавиатуры и виртуальных кнопок
	var keyboard_input = Vector2(
		Input.get_action_strength("right") - Input.get_action_strength("left"),
		Input.get_action_strength("down") - Input.get_action_strength("up")
	)
	return move_input + keyboard_input

func die():
	anima.play("Death")
	await anima.animation_finished
	queue_free()
	# get_tree().change_scene_to_file("res://Scenes/menu.tscn")  # Вернуть игрока в меню

# Обработчики виртуальных кнопок
func _on_up_pressed():
	move_input.y = -1

func _on_right_pressed():
	move_input.x = 1

func _on_left_pressed():
	move_input.x = -1

func _on_down_pressed():
	move_input.y = 1

func _on_attack_pressed():
	if glitch == true or long_glitch == true:
		anima.play("glitch_Attack")
	else:
		anim.play("attack") 
	
func _on_glitch_pressed():
	pass  # Здесь можно добавить логику глитча

func _on_bag_pressed():
	pass  # Здесь можно добавить логику инвентаря



func _on_up_released() -> void:
	move_input.y = 0

func _on_right_released() -> void:
	move_input.x = 0

func _on_left_released() -> void:
	move_input.x = 0
	
func _on_down_released() -> void:
	move_input.y = 0

func _on_attack_released() -> void:
	attacking = false

func _on_glitch_released() -> void:
	pass # Replace with function body.

func _on_bag_released() -> void:
	pass # Replace with function body.



func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "rogue":
			if Input.is_action_just_pressed("attack"):
				anim.play("attack")
				body.health -= damage
				
func _on_damage_received(enemy_damage):
	health -= enemy_damage
	emit_signal("HP_changed", health)
		


func _on_hurt_box_area_entered(area: Area2D):
	if Input.is_action_pressed("attack"):
		Signals.emit_signal("player_attack", damage)
