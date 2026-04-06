extends Node
class_name MissionHandler

var player

func _ready() -> void:
	
	pass 

func _create_mission(missao: MissoesData, player) -> bool:
	if !player:
		player = get_tree().get_first_node_in_group("Player")
	var Plmissao = player.PlayerStats[1]
	Plmissao.missao.append(missao)
	print(Plmissao.missao.size())
	print("Missão criada")
	
	
	return true

func _get_missions(player, i: int) -> String:
	var t
	if !player:
		player = get_tree().get_first_node_in_group("Player")
	var Plmissao = player.PlayerStats[1]
	t = Plmissao.missao[i].nomeMissao
	return t
