extends Node2D

@onready var animation = $CollectiblesAnimation
var anim_finish = false
var in_collect = false
var center = Global.center
var offset_pos = 10
var speed_infinite = 1

func _ready():
	match Global.start_level:
		"Infinite":
			position = Vector2(center.x * 2, center.y - offset_pos)

func _physics_process(delta):
	match Global.start_level:
		"Infinite":
			position.x -= (Global.speed * delta) + speed_infinite
			_check_limit()

func _on_hitt_collection_area_entered(area):
	if area.is_in_group("player"):
		in_collect = true
		animation.play("collect")
		if anim_finish:
			self.queue_free()
			in_collect = false

func _on_collectibles_animation_animation_finished(anim_name):
	if anim_name == "collect":
		anim_finish = true
		Global.add_score_game()
		if Global.amount_collectibles <= 0:
			Global.amount_collectibles += 1
		#if Global.score_game % Global.points_to_next_level == 0:
			#Global.add_level()
		Global.add_level()

func _check_limit():
	if position.x < -10 and !in_collect:
		queue_free()
		if Global.amount_collectibles <= 0:
			Global.amount_collectibles += 1
