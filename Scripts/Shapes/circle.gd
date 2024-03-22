extends Path2D

@onready var player = get_node("CircleFollow/_Player")
var ray_circle = Global.circle_radius + 15
var center = Global.center
var out = true

func _ready():
	create_circle_out()

func _physics_process(_delta):
	move()

func create_circle_out():
	# Limpa todos os pontos existentes
	get_curve().clear_points()

	# Adiciona 8 pontos para criar um círculo
	for i in range(Global.points):
		# Calcula a posição do ponto no círculo
		var angle = i * (2 * PI / Global.points)
		var x = cos(angle)
		var y = sin(angle)

		# Adiciona o ponto ao caminho
		get_curve().add_point(Vector2(x, y) * ray_circle)
		position = center

func move():
	if Input.is_action_just_pressed("click"):
		if out:
			out = false
			player.scale = Vector2(0.4, 0.4)
			scale.x = 0.73
			scale.y = 0.73
		else:
			out = true
			player.scale = Vector2(0.3, 0.3)
			scale.x = 1
			scale.y = 1
