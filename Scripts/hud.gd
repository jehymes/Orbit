extends Control

var level_game = 0
@onready var Score_1 = $Background/ScoreBox/Score_1/Numbers
@onready var Score_2 = $Background/ScoreBox/Score_2/Numbers
@onready var Score_3 = $Background/ScoreBox/Score_3/Numbers

func _ready():
	$Background/ScoreBox.position.x = Global.V_WIDTH/2

func _process(_delta):
	check_levels()
	$Background/Collect.text = str(Global.score_game)

func add_frame(object, frame):
	object.frame = frame

func check_levels():
	if Global.level <= 9:
		add_frame(Score_3, Global.level)
		return
	
	if Global.level > 9 && Global.level <= 99:
		var pos_1 = int(str(Global.level)[0])
		var pos_2 = int(str(Global.level)[1])

		add_frame(Score_3, pos_2)
		add_frame(Score_2, pos_1)
		return
	
	if Global.level > 99 && Global.level <= 999:
		var pos_1 = int(str(Global.level)[0])
		var pos_2 = int(str(Global.level)[1])
		var pos_3 = int(str(Global.level)[2])
		
		add_frame(Score_3, pos_3)
		add_frame(Score_2, pos_2)
		add_frame(Score_1, pos_1)
		return
