extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

#var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var health = 100


#@onready var anima = $AnimatedSprite2D

func _physics_process(delta: float) -> void:
	# Add the gravity.
	#if not is_on_floor():
		#velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		#anima.play("Jumping")

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
		#if velocity.y == 0:
			#anima.play("Running")
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		#if velocity.y == 0:
			#anima.play("Idle")
		
	#if direction == -1:
		#$AnimatedSprite2D.flip_h = true
	#elif direction == 1:
		#$AnimatedSprite2D.flip_h = false
		
	#if velocity.y > 0:
		#anima.play("Falling")
	
	#if health <= 0:
		#anima.play("Death")
		#await anima.animation_finished
		queue_free()
		get_tree().change_scene_to_file("res://Scenes/menu.tscn")

	move_and_slide()
