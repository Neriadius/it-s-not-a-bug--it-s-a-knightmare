extends Node2D

var glitch_shade : Node2D # Переменная для ссылки на глитч-ноду


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	glitch_shade = $Glit  # Получаем ссылку на ноду с именем Glit
	glitch_shade.hide()  # Прячем ноду
	# Отключаем шейдер, если он есть
	if glitch_shade.material:
		glitch_shade.material.set_shader_param("enabled", false)  # Отключаем шейдер

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass  # Здесь можно добавлять логику обновления сцены, если нужно

# Пример метода, который можно вызвать, когда нода должна стать скрытой


func _on_glit_hidden() -> void:
	glitch_shade.hide()  # Прячем ноду
	if glitch_shade.material:
		glitch_shade.material.set_shader_param("enabled", false)  


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		body.SPEED *= 0.9


func _on_area_2d_2_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		body.SPEED *= 0.6

func _on_area_2d_3_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		body.SPEED *= 0.4


func _on_area_2d_4_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		body.SPEED *= 0.3


func _on_area_2d_5_body_entered(body: Node2D) -> void:
		if body.name == "Player":
			body.SPEED *= 0.1
