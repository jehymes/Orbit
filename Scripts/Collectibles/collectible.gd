extends Node2D

@onready var animation = $CollectiblesAnimation
var anim_finish = false

func _on_hitt_collection_area_entered(area):
	if area.is_in_group("player"):
		animation.play("collect")
		if anim_finish:
			self.queue_free()

func _on_collectibles_animation_animation_finished(anim_name):
	if anim_name == "collect":
		anim_finish = true
		Global.add_score_game()
		Global.amount_collectibles += 1
		#Global.add_level()
		if Global.score_game % Global.points_to_next_level == 0:
			Global.add_level()
