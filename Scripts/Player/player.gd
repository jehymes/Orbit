extends CharacterBody2D

@export var deathParticle: PackedScene
var center = Global.center
var offset_pos = 35
var out = true

func _ready():
	match Global.start_level:
		"Infinite":
			position = Vector2((center.x) + offset_pos, (center.y * 3) + offset_pos)

func _physics_process(_delta):
	move()

func move():
	if Input.is_action_just_pressed("click"):
		if out:
			out = false
			position = Vector2((center.x) + offset_pos, (center.y * 3) + 125)
			print(position) 
		else:
			out = true
			position = Vector2((center.x) + offset_pos, (center.y * 3) + offset_pos)

func _on_hitt_player_area_entered(area):
	if area.is_in_group("enemies"):
		Global.speed = 0
		kill()

func kill():
	var _particle = deathParticle.instantiate()
	_particle.position = global_position
	_particle.rotation = global_rotation
	_particle.emitting = true
	get_tree().current_scene.add_child(_particle)
	
	queue_free()
