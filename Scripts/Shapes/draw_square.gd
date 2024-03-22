extends Node2D

var offset_x = Global.center.x - (Global.square_size/2)
var offset_y = Global.center.y - (Global.square_size/2)

# Tamanho do quadrado
var square_size = Global.square_size

func _draw():
	# Desenha as bordas do quadrado
	draw_square_borders(square_size)
	position = Vector2(offset_x, offset_y)

func draw_square_borders(size):
	# Calcula as coordenadas dos vértices do quadrado
	var top_left = Vector2(0, 0)
	var top_right = top_left + Vector2(size, 0)
	var bottom_left = top_left + Vector2(0, size)
	var bottom_right = top_left + Vector2(size, size)

	# Lista de vértices que formam as bordas do quadrado
	var vertices = [top_left, top_right, bottom_right, bottom_left]

	# Desenha as linhas que conectam os vértices
	for i in range(vertices.size()):
		var start = vertices[i]
		var end = vertices[(i + 1) % vertices.size()] # Conecta o último vértice de volta ao primeiro
		draw_line(start, end, Color.WHITE, 2, true)
