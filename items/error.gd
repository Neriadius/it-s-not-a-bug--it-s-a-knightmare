extends Node2D


func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		body.glitch = true
		queue_free()
