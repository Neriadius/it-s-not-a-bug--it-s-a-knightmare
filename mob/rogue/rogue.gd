extends CharacterBody2D

var SPEED = 80
var alive = true
var HP = 40
var fight = false

@onready var anima = $AnimatedSprite2D
@onready var anim = $AnimationPlayer
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var direction = get_direction_to_player()
	if alive == true:
		velocity = SPEED * direction
		if direction.x > 0:
			$AnimatedSprite2D.flip_h = true
		else:
			$AnimatedSprite2D.flip_h = false
	
	if HP == 0:
		death()
	
	move_and_slide()

func get_direction_to_player():
	var player = get_tree().get_first_node_in_group("player") as Node2D
	if player != null:
		return (player.global_position - self.global_position).normalized()
	return Vector2.ZERO
	
func death():
	alive = false
	await anima.animation_finished
	queue_free()


func _on_attack_body_entered(body: Node2D):
	fight = true
	if body.name == "Player":	
		anim.play("Attack")
		if body.shield > 0:
			body.shield -=3
		else:
			body.health -= 5
