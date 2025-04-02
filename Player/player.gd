extends CharacterBody2D

const SPEED = 100.0
var health = 100

@onready var anima = $CollisionShape2D/AnimatedSprite2D

func _process(delta):
	var movement = movement_vector()
	var direction = movement.normalized()
	velocity = SPEED * direction
	
	# Handle horizontal movement and animation state
	if direction.length() > 0:
		velocity.x = direction.x * SPEED
		if velocity.y == 0:
			anima.play("Run")
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED * delta)  # Smooth deceleration
		if velocity.y == 0:
			anima.play("Idle")
	
	# Flip the sprite depending on movement direction
	if direction.x < 0:
		$CollisionShape2D/AnimatedSprite2D.flip_h = true
	elif direction.x > 0:
		$CollisionShape2D/AnimatedSprite2D.flip_h = false
	
	# Handle health and death
	if health <= 0:
		anima.play("Death")
		await anima.animation_finished
		queue_free()
		# get_tree().change_scene_to_file("res://Scenes/menu.tscn")  # Uncomment to return to the menu
		return  # Prevent further movement when the character is dead
	
	move_and_slide()

func movement_vector():
	var movement_x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	var movement_y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	return Vector2(movement_x, movement_y)
	
