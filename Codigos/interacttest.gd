extends Node3D
@export var missao: Array[MissoesData]

var Player
var TextoInte
var IntArea
var perdesanidade: bool

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	TextoInte = get_node("Label3D")
	IntArea = get_node("Area de interação")
	IntArea.area_entered.connect(_on_area_3d_area_entered)
	IntArea.area_exited.connect(_on_area_3d_area_exited)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if perdesanidade:
		Player.PlayerStats[0].sanidade -= 0.15
		Player.PlayerStats[0].sanidade = snappedf(Player.PlayerStats[0].sanidade, 0.01)
		await 100
	pass

func _on_area_3d_area_entered(area: Area3D) -> void:
	TextoInte.text = "aperte E para interagir"
	add_to_group("Player")
	Player = get_tree().get_first_node_in_group("Player")
	print(Player)
	if not Player.interact.connect(_on_player_interact):
		Player.interact.connect(_on_player_interact)

func _on_area_3d_area_exited(area: Area3D) -> void:
	remove_from_group("Player")
	TextoInte.text = ""

func _on_player_interact(Interact: Variant) -> void:
	if is_in_group("Player"):
		if Interact == 1:
			var afonso = get_node("AFONSO")
			if afonso.visible == false:
				afonso.visible = true
				var chat = ResourceLoader.load("res://GUIandHUDS/chat_gui.tscn")
				add_child(chat)
				perdesanidade = true
				var miHdr = preload("res://Codigos/MissionHandler.gd").new()
				for i in missao.size():
					if missao[i].missaoDada:
						pass
					else:
						missao[i].missaoDada = miHdr._create_mission(missao[i], Player)
			else:
				perdesanidade = false
				afonso.visible = false
