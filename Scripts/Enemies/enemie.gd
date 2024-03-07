extends Node2D

var ENEMIE_PATH = preload("res://Props/Enemies/enemies.tscn")
var positions: Array[Vector2]
var angles: Array[float]
var position_offset = 9

func _ready():
	randomize()
	generate_positions()

func _process(_delta):	
	if Global.amount_enemies > 0:
		$EnemieBox.monitoring = true
		# Escolhe o index do posicionamento
		var index = randi_range(0, positions.size())
		
		# Instancia o coletável
		var enemie = ENEMIE_PATH.instantiate()
		enemie.scale = Vector2(0.3, 0.3)
		
		if !Global.is_object_at_position(positions[index-1]):
			enemie.position = positions[index-1]
			enemie.rotation_degrees = rad_to_deg(angles[index-1]) - 5
			add_child(enemie)
			Global.amount_enemies += -1
			return

func generate_positions():
	var center = Global.center
	var radius_1 = Global.circle_radius + position_offset
	var radius_2 = Global.circle_radius - position_offset

	# Rotaciona as instâncias para acompanhar o círculo
	var rotationOffset = deg_to_rad(90)

	for i in range(Global.points):
		var in_or_out = randi_range(1, 2)
		# Calcula a posição do quadrado no círculo
		var angle = i * (2 * PI / Global.points) + rotationOffset
			
		#Define posicionamento do coletável
		if in_or_out == 1:
			var enemiePosition = center + Vector2(radius_1 * cos(angle), radius_1 * sin(angle))
			# Define as posições para o coletável
			positions.append(enemiePosition)
			angles.append(angle)
		if in_or_out == 2:
			var enemiePosition = center + Vector2(radius_2 * cos(angle), radius_2 * sin(angle))
			# Define as posições para o coletável
			positions.append(enemiePosition)
			angles.append(angle)
