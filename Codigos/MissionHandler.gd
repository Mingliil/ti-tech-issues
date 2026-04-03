extends Node
class_name MissionHandler

var player

func _ready() -> void:
	pass 

func _create_mission(missao: MissoesData, player) -> bool:
	if !player:
		player = get_tree().get_first_node_in_group("Player")
	var plStat = player.PlayerStats
	plStat.append(missao)
	print(player.PlayerStats.size())
	print("Missão criada")
	
	print(player.get_viewport().get_visible_rect().size)
	return true

func _get_missions() -> void:
	pass
