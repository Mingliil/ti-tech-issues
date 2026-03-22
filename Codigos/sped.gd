extends Label

func _on_player_pl_speed(Plspeed: Variant) -> void:
	text = "Speed: %s treste" %Plspeed.z + "VelX = %x" %Plspeed.x
