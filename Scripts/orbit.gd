extends Node2D

var hud = preload("res://Props/Models/hud.tscn").instantiate()
var circle_level = preload("res://Props/Shapes/circle.tscn").instantiate()
var collectible = preload("res://Props/Collectibles/collectibles.tscn").instantiate()
var enemie = preload("res://Props/Enemies/enemies.tscn").instantiate()

var score = 0
var level = 0

func _ready():
	add_child(circle_level)
	add_child(enemie)
	add_child(collectible)
	add_child(hud)

func is_object_at_position(check: Vector2) -> bool:
	# Verifica se existe algum objeto na posição
	for child in get_children():
		if child.is_in_group("collectible") || child.is_in_group("enemie"):
			if child.position == check:
				return true
	return false
