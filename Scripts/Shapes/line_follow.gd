extends PathFollow2D

func _process(delta):
	progress_ratio -= delta * Global.speed
