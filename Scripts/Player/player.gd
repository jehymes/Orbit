extends CharacterBody2D

@onready var animation = $Animation
var is_dead = false

func on_hitt_box_area_entered(area):
	if area.is_in_group("enemie"):
		animation.play("explode")
		Global.speed = 0
		if is_dead:
			self.queue_free()

func on_animation_player_animation_finished(anim_name):
	if anim_name == "explode":
		is_dead = true
