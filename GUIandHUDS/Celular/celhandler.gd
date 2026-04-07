extends Control

@onready var player
@onready var botaoMissao = preload("res://GUIandHUDS/Celular/botaomissao.tscn")
@onready var appUso: VBoxContainer = $tela/appUso/botaoCaixa
@onready var textoTest: RichTextLabel = $tela/RichTextLabel
var botaoMissaoExiste: bool = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player = get_tree().get_first_node_in_group("Player")
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_up"):
		missao_botao()
	pass

func missao_botao() -> void:
	var miHdr = preload("res://Codigos/MissionHandler.gd").new()
	if botaoMissaoExiste:
		if appUso.get_child_count() == 0:
			pass
		else: 
				for i in appUso.get_child_count():
					appUso.get_child(i).queue_free()
		botaoMissaoExiste = false
	else:
		for i in player.PlayerStats[1].missao.size():
			var btMissao = botaoMissao.instantiate()
			btMissao.text = miHdr._get_missions(get_tree().get_first_node_in_group("Player"), i)
			appUso.add_child(btMissao)
		botaoMissaoExiste = true
