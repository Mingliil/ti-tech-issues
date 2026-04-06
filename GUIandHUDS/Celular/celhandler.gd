extends Control

@onready var player
@onready var botaoMissao = preload("res://GUIandHUDS/Celular/botaomissao.tscn")
@onready var appUso: ReferenceRect = $tela/appUso
@onready var textoTest: RichTextLabel = $tela/RichTextLabel
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player = get_tree().get_first_node_in_group("Player")
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var miHdr = preload("res://Codigos/MissionHandler.gd").new()
	if Input.is_action_just_pressed("ui_up"):
		for i in player.PlayerStats[1].missao.size():
			var btMissao = botaoMissao.instantiate()
			btMissao.get_node("Button").text += miHdr._get_missions(get_tree().get_first_node_in_group("Player"), i)
			appUso.add_child(btMissao)
	pass
