extends CharacterBody2D

const SPEED = 100.0
var health = 100
var move_input = Vector2() # Хранит текущий ввод

@onready var anima = $CollisionShape2D/AnimatedSprite2D

func _process(delta):
	# Двигаем персонажа
	var movement = movement_vector()
	velocity = movement.normalized() * SPEED
	
	# Анимации
	if movement.length() > 0:
		if velocity.y == 0:
			anima.play("Run")
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED * delta)  # Плавное замедление
		if velocity.y == 0:
			anima.play("Idle")
	
	# Отражение спрайта
	$CollisionShape2D/AnimatedSprite2D.flip_h = (velocity.x < 0)
	
	# Проверка здоровья
	if health <= 0:
		die()
		return

	
	move_and_slide()

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
	pass  # Здесь можно добавить логику атаки

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
