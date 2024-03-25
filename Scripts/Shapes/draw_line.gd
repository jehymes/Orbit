extends Node2D

var center = Global.center
var color = Color.WHITE
var expessure = 1
var antialiased = true
var line = 1

func _ready():
	Global.start_level = "Infinite"

func _draw():
	draw_line(Vector2(0, center.y), Vector2(center.x * 2 + 15, center.y + line), color, expessure, antialiased)
