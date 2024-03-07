extends Node

# Game
var V_WIDTH = ProjectSettings.get_setting("display/window/size/viewport_width")
var V_HEIGHT = ProjectSettings.get_setting("display/window/size/viewport_height")
var level = 0
var points_to_next_level = 10 if level == 0 else (level+1) * 10
var best_score = 0
var score_game = 0

#Circle
var points = 360
var circle_radius = 100
var center = Vector2(V_WIDTH/2, V_HEIGHT/2)

#Player
var speed = 0.5
var player_scale = Vector2(0.4, 0.4)

#Enemies
var amount_enemies = 0

#Collectibles
var amount_collectibles = 1

# ---------------------------------------| Functions | ------------------------------------------- #
func is_object_at_position(check: Vector2) -> bool:
	# Verifica se existe algum objeto na posição
	for child in get_children():
		if child.is_in_group("collectible") || child.is_in_group("enemie"):
			if child.position == check:
				return true
	return false

func add_level():
	level += 1
	points_to_next_level = 10 if level == 0 else (level+1) * 10
	amount_enemies += 1

func add_score_game():
	score_game += 1
