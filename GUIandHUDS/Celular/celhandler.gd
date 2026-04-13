extends CanvasLayer

@onready var player
@onready var botaoMissao = preload("res://GUIandHUDS/Celular/botaomissao.tscn")
@onready var appUso: = $TelaNormal/AreaApp
@onready var aplicativos = preload("res://GUIandHUDS/Celular/Aplicativos/Aplicativos.tscn")
var botaoMissaoExiste: bool = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player = get_tree().get_first_node_in_group("Player")
	_change_phone_size()
	if !get_viewport().size_changed.is_connected(_change_phone_size):
		get_viewport().size_changed.connect(_change_phone_size)
	var app:Control = aplicativos.instantiate()
	appUso.add_child(app)
	adapt_app_size()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_up"):
		missao_botao()
		pass
func mude_app_aba(preloadAba: PackedScene) -> void:
	appUso.get_child(0).queue_free()
	appUso.add_child(preloadAba.instantiate())

func missao_botao() -> void:
	var miHdr = preload("res://Codigos/MissionHandler.gd").new()
	var tabelaMissoes: VBoxContainer = get_node("/root/Celular/TelaNormal/AreaApp/MissionHub/MissionArea/Scroll/MissionBox")
	if botaoMissaoExiste:
		if appUso.get_child_count() == 0:
			pass
		else: 
				for i in appUso.get_child_count():
					tabelaMissoes.get_child(i).queue_free()
		botaoMissaoExiste = false
	else:
		for i in player.PlayerStats[1].missao.size():
			var btMissao = botaoMissao.instantiate()
			btMissao.text = miHdr._get_missions(get_tree().get_first_node_in_group("Player"), i)
			tabelaMissoes.add_child(btMissao)
			tabelaMissoes.get_child(i).scale.x = appUso.size.x / appUso.get_child(0).get_child(0).size.x
		botaoMissaoExiste = true

#funcionam para arrumar o tamanho de tudo relacionado
func _change_phone_size() -> void:
	offset.x = get_viewport().get_visible_rect().size.x/1.2
	offset.y = get_viewport().get_visible_rect().size.y
	scale.x = 1*(offset.x/900)
	scale.y = 1*(offset.x/900)

func adapt_app_size() -> void:
	var appRoot: Control = appUso.get_child(0)
	appRoot.get_child(0).scale.x = appUso.size.x / appRoot.get_child(0).size.x
	appRoot.get_child(0).scale.y = appRoot.get_child(0).scale.x
	pass
