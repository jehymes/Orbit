extends Node2D

@export_category("Draw Circle")
var radius = Global.circle_radius
var color = Color.WHITE
var alliasing = true
var expessure = 1

var angle_from = 0
var angle_to = 7
var center = Global.center
var points = Global.points

func _init():
	Global.start_level = "Circle"

func _draw():
	draw_arc(center, radius, angle_from, angle_to, points, color, expessure, alliasing) 
