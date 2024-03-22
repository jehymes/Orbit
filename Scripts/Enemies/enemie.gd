extends Node2D

func _on_hitt_enemie_area_entered(area):
	if area.is_in_group("enemies"):
		var ene = area.get_parent()
		ene.queue_free()
		Global.amount_enemies += 1
		
	if area.is_in_group("collectibles"):
		var col = area.get_parent()
		col.queue_free()
		Global.amount_collectibles += 1
