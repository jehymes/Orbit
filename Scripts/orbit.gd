extends Node2D

var hud = preload("res://Props/Models/hud.tscn").instantiate()
var collectible = preload("res://Props/Collectibles/_collectibles.tscn")
var enemie = preload("res://Props/Enemies/_enemies.tscn")

#Variáveis dos coletáveis
var positions_col: Array[Vector2]
var positions_sqr: Array[Vector2]
var angles_col: Array[float]
var col_position_offset = 15
var count = 0

#Variáveis dos inimigos
var positions_ene: Array[Vector2]
var angles_ene: Array[float]
var ene_position_offset = 9

var score = 0
var level = 0
var r = Global.color_r
var g = Global.color_g
var b = Global.color_b

func _ready():
	add_child(hud)
	
	match Global.start_level:
		"Circle":
			print("Circle_Level")
			generate_positions_collectibles()
			generate_positions_enemies()
		"Square":
			hud.get_node("Background/ColorRect").color = Color(r, g, b, 1)
			generate_positions_collectibles()
			#generate_positions_enemies()
			pass

func _process(_delta):
	match Global.start_level:
		"Circle":
			add_collectibles()
			add_enemies()
		"Square":
			#hud.get_node("Background/ColorRect").color = Color(1, 0, 1, 1)
			add_collectibles()
			#Add Enemies
			pass

func add_collectibles():
	if Global.amount_collectibles > 0:
		var index = randi_range(0, positions_sqr.size())
		
		# Instancia o coletável
		var collect = collectible.instantiate()
		
		match Global.start_level:
			"Circle":
				if !is_object_at_position(positions_col[index-1]):
					if count < 49:
						collect.position = positions_col[index-1]
						collect.rotation_degrees = rad_to_deg(angles_col[index-1])
						get_tree().current_scene.add_child(collect)
						Global.amount_collectibles += -1
						count += 1
					else:
						var sprite_col = collect.get_node("Sprite")
						sprite_col.modulate = Color(1,1,0.2)
						collect.position = positions_col[index-1]
						collect.rotation_degrees = rad_to_deg(angles_col[index-1])
						get_tree().current_scene.add_child(collect)
						Global.amount_collectibles += -1
						count = 0
					return
			"Square":
				if !is_object_at_position(positions_sqr[index-1]):
					if count < 49:
						collect.position = positions_sqr[index-1]
						get_tree().current_scene.add_child(collect)
						Global.amount_collectibles += -1
						count += 1
					else:
						var sprite_col = collect.get_node("Sprite")
						sprite_col.modulate = Color(1,1,0.2)
						collect.position = positions_sqr[index-1]
						get_tree().current_scene.add_child(collect)
						Global.amount_collectibles += -1
						count = 0
					return

func add_enemies():
	if Global.amount_enemies > 0:
		if Global.amount_enemies_for_level > 0:
			# Escolhe o index do posicionamento
			var index = randi_range(0, positions_ene.size())
			
			# Instancia o coletável
			var enemy = enemie.instantiate()
			enemy.scale = Vector2(0.3, 0.3)
			
			if !is_object_at_position(positions_ene[index-1]):
				enemy.position = positions_ene[index-1]
				enemy.rotation_degrees = rad_to_deg(angles_ene[index-1])
				add_child(enemy)
				Global.amount_enemies += -1
				Global.amount_enemies_for_level += -1
				return

func generate_positions_collectibles():
	var center = Global.center
		
	match Global.start_level:
		"Circle":
			for i in range(Global.points):
				var in_or_out = randi_range(1, 2)

				var radius_1 = Global.circle_radius + col_position_offset
				var radius_2 = Global.circle_radius - col_position_offset
				
				# Rotaciona as instâncias para acompanhar o círculo
				var rotationOffset = deg_to_rad(90)
				
				# Calcula a posição do quadrado no círculo
				var angle = i * (2 * PI / Global.points) + rotationOffset
					
				#Define posicionamento do coletável
				if in_or_out == 1:
					var collectPosition = center + Vector2(radius_1 * cos(angle), radius_1 * sin(angle))
					# Define as posições para o coletável
					positions_col.append(collectPosition)
					angles_col.append(angle)
				if in_or_out == 2:
					var collectPosition = center + Vector2(radius_2 * cos(angle), radius_2 * sin(angle))
					# Define as posições para o coletável
					positions_col.append(collectPosition)
					angles_col.append(angle)
		"Square":
			for i in range(50):
				var in_or_out = randi_range(1, 2)
				var pos_spawn = define_pos_spawn_square(randi_range(1, 4), in_or_out)
				
				#Define posicionamento do coletável
				if in_or_out == 1:
					var collectPosition = pos_spawn[randi_range(0, pos_spawn.size()-1)]
					
					# Define as posições para o coletável
					positions_sqr.append(collectPosition)
					
				if in_or_out == 2:
					var collectPosition = pos_spawn[randi_range(0, pos_spawn.size()-1)]
					
					# Define as posições para o coletável
					positions_sqr.append(collectPosition)

func generate_positions_enemies():
	randomize()
	var center = Global.center
	var radius_1 = Global.circle_radius + ene_position_offset
	var radius_2 = Global.circle_radius - ene_position_offset
	
	# Rotaciona as instâncias para acompanhar o círculo
	var rotationOffset = deg_to_rad(randi_range(1, 360))

	for i in range(Global.amount_enemies_for_level):	
		var in_or_out = randi_range(1, 2)
		# Calcula a posição do quadrado no círculo
		var angle = i * (2 * PI / Global.amount_enemies_for_level) + rotationOffset
			
		#Define posicionamento do coletável
		if in_or_out == 1:
			var enemiePosition = center + Vector2(radius_1 * cos(angle), radius_1 * sin(angle))
			# Define as posições para o coletável
			positions_ene.append(enemiePosition)
			angles_ene.append(angle)
		if in_or_out == 2:
			var enemiePosition = center + Vector2(radius_2 * cos(angle), radius_2 * sin(angle))
			# Define as posições para o coletável
			positions_ene.append(enemiePosition)
			angles_ene.append(angle)

func is_object_at_position(check: Vector2) -> bool:
	# Verifica se existe algum objeto na posição
	var offset = Vector2(int(check.x) + 16, int(check.y) + 16) 
	var n_check = Vector2(int(check.x), int(check.y))
	for child in get_children():
		var verify = Vector2(int(child.position.x), int(child.position.y))
		if child.is_in_group("collectibles") || child.is_in_group("enemies"):
			if verify == n_check || verify + offset == n_check || verify - offset == n_check:
				return true
	return false

func define_pos_spawn_square(side_square, in_out) -> Array[Vector2]:
	var positions: Array[Vector2]
	if in_out == 1:
		match side_square:
			1:
				for i in range(230):
					positions.append(Vector2(125+(i+1), 125))
			2:
				for i in range(230):
					positions.append(Vector2(355, 125+(i+1)))
			3:
				for i in range(230):
					positions.append(Vector2(355 - (i+1), 355))
			4:
				for i in range(230):
					positions.append(Vector2(125, 355 - (i+1)))
	else:
		match side_square:
			1:
				for i in range(170):
					positions.append(Vector2(155+(i+1), 155))
			2:
				for i in range(170):
					positions.append(Vector2(325, 155+(i+1)))
			3:
				for i in range(170):
					positions.append(Vector2(325 - (i+1), 325))
			4:
				for i in range(170):
					positions.append(Vector2(155, 325 - (i+1)))
	
	return positions
