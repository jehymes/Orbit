extends CharacterBody2D

@export var deathParticle: PackedScene

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
