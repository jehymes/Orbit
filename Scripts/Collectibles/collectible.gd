extends Node2D

@onready var animation = $Animation

var COLLECTIBLE_PATH = preload("res://Props/Collectibles/collectibles.tscn")
var positions: Array[Vector2]
var angles: Array[float]
var check_enemies = false
var anim_finish = false
var position_offset = 15

func _ready():
	generate_positions()
	randomize()

func _process(_delta):
	if Global.amount_collectibles > 0:
		var index = randi_range(0, positions.size())
		
		# Instancia o coletável
		var collect = COLLECTIBLE_PATH.instantiate()
		collect.scale = Vector2(0.2, 0.2)
		
		#TODO - Checar validação de posicionamento
		if !Global.is_object_at_position(positions[index-1]):
			collect.position = positions[index-1]
			collect.rotation_degrees = rad_to_deg(angles[index-1]) - 5
			add_child(collect)
			Global.amount_collectibles += -1
			return

func generate_positions():
	var center = Global.center
	var radius_1 = Global.circle_radius + position_offset
	var radius_2 = Global.circle_radius - position_offset

	# Rotaciona as instâncias para acompanhar o círculo
	var rotationOffset = deg_to_rad(90)
	
	# Número de coletáveis por fase
	var numCollectibles = int(2 * PI * Global.circle_radius / 16)
	print(numCollectibles)

	for i in range(Global.points):
		var in_or_out = randi_range(1, 2)
		# Calcula a posição do quadrado no círculo
		var angle = i * (2 * PI / Global.points) + rotationOffset
			
		#Define posicionamento do coletável
		if in_or_out == 1:
			var collectPosition = center + Vector2(radius_1 * cos(angle), radius_1 * sin(angle))
			# Define as posições para o coletável
			positions.append(collectPosition)
			angles.append(angle)
		if in_or_out == 2:
			var collectPosition = center + Vector2(radius_2 * cos(angle), radius_2 * sin(angle))
			# Define as posições para o coletável
			positions.append(collectPosition)
			angles.append(angle)

func on_hitt_box_area_entered(area):		
	if area.is_in_group("player"):
		animation.play("collect")
		check_enemies = true
		if anim_finish:
			self.queue_free()

func on_animation_finished(anim_name):
	if anim_name == "collect":
		anim_finish = true
		Global.add_score_game()
		Global.amount_collectibles += 1
		if Global.score_game % Global.points_to_next_level == 0:
			Global.add_level()

func remove_object(object):
	object.queue_free()
