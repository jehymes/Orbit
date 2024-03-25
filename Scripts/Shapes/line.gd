extends Path2D

var center = Global.center
var size_line = center.x * 2 
var line = 1

func _physics_process(_delta):
	move()

func move():
	# Limpa todos os pontos existentes
	get_curve().clear_points()

	# Adiciona os pontos para criar uma linha
	get_curve().add_point(Vector2(0, 0))
	get_curve().add_point(Vector2(line, 0))
