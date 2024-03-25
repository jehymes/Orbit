extends Node

# Game
var V_WIDTH = ProjectSettings.get_setting("display/window/size/viewport_width")
var V_HEIGHT = ProjectSettings.get_setting("display/window/size/viewport_height")
var center = Vector2(V_WIDTH/2, V_HEIGHT/2)
var start_level = "Circle"
var points = 360
var level = 0
var points_to_next_level = 10 if level == 0 else (level+1) * 10
var best_score = 0
var score_game = 0

#Circle
var circle_radius = 100

#Square
var square_size = 200

#Player
var speed = 0.3
var player_scale = Vector2(0.4, 0.4)

#Enemies
var amount_enemies = 0
var amount_enemies_for_level = 5

#Collectibles
var amount_collectibles = 1

#Colors
var color_r = randf_range(0, 1)
var color_g = randf_range(0, 1)
var color_b = randf_range(0, 1)

# ---------------------------------------| Functions | ------------------------------------------- #
func _ready():
	randomize()

func add_level():
	level += 1
	points_to_next_level = 10 if level == 0 else (level+1) * 10
	amount_enemies += 1

func add_score_game():
	score_game += 1
	speed += 0.001

func next_level(_name):
	start_level = _name
