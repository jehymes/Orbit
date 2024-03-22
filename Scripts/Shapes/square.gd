extends Path2D

@onready var player = get_node("SquareFollow/_Player")
var size_square = Global.square_size + 30
var offset_pos = size_square/2
var center = Global.center
var out = true
var offset_inner: int = 30

func _ready():
	create_square_out()

func _physics_process(_delta):
	move()

func create_square_out():
	# Limpa todos os pontos existentes
	get_curve().clear_points()

	# Adiciona 8 pontos para criar um círculo
	get_curve().add_point(Vector2(0, 0))
	get_curve().add_point(Vector2(size_square, 0))
	get_curve().add_point(Vector2(size_square, size_square))
	get_curve().add_point(Vector2(0, size_square))
	get_curve().add_point(Vector2(0, 0))
	
	position = Vector2(center.x - offset_pos, center.y - offset_pos) 

func move():
	if Input.is_action_just_pressed("click"):
		if out:
			var scaling = 0.74
			out = false
			position = Vector2(center.x - (offset_pos - offset_inner), center.y - (offset_pos - offset_inner))
			player.scale = Vector2(0.4, 0.4)
			scale = Vector2(scaling, scaling)
		else:
			out = true
			position = Vector2(center.x - offset_pos, center.y - offset_pos)
			player.scale = Vector2(0.3, 0.3)
			scale.x = 1
			scale.y = 1
