extends CharacterBody2D

var SPEED = 80
var alive = true
var HP = 40
var damage = 5
var fight = false

@onready var anima = $CollisionShape2D/AnimatedSprite2D
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Signals.connect("player_attack", Callable(self, "_on_damage_received"))
	add_to_group("enemy")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var play = get_tree().get_current_scene().get_node("Player") as Node2D
	var direction = get_direction_to_player()
	if alive == true:
		velocity = SPEED * direction
		anima.play("default")
		if direction.x > 0:
			$CollisionShape2D/AnimatedSprite2D.flip_h = true
		else:
			$CollisionShape2D/AnimatedSprite2D.flip_h = false
	else:
		velocity.x = 0
		velocity.y = 0
	
	if HP <= 0:
		queue_free()
		play.kill_count += 1
		
	
	move_and_slide()

func get_direction_to_player():
	var play = get_tree().get_current_scene().get_node("Player") as Node2D
	if play != null:
		return (play.global_position - self.global_position).normalized()
	return Vector2.ZERO
	
func death():
	alive = false
	await anima.animation_finished
	queue_free()


func _on_hurt_box_area_entered(area):
	Signals.emit_signal("enemy_attack", damage)
	
func _on_damage_received(player_damage):
	HP -= player_damage
