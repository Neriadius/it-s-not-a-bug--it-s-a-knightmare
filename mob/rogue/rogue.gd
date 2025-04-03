extends CharacterBody2D

var SPEED = 80
var alive = true
var HP = 40

@onready var anima = $AnimatedSprite2D
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var direction = get_direction_to_player()
	if alive == true:
		velocity = SPEED * direction
		anima.play()
		if direction.x > 0:
			$AnimatedSprite2D.flip_h = true
		else:
			$AnimatedSprite2D.flip_h = false
	
	if HP == 0:
		death()
	
	move_and_slide()
	
func _on_finding_body_entered(body: Node2D) -> void:
	if body.name == "player":
		attack()


func attack():
	anima.play("new_animation")
	


func get_direction_to_player():
	var player = get_tree().get_first_node_in_group("player") as Node2D
	if player != null:
		return (player.global_position - self.global_position).normalized()
	return Vector2.ZERO
	
func death():
	alive = false
	anima.play()
	await anima.animation_finished
	queue_free()


func _on_hit_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		anima.play("new_animation")
		if body.shield > 0:
			body.shield -=3
		else:
			body.health -= 5
