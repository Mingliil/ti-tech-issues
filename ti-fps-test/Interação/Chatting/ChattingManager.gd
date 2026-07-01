extends Node





# Called when the node enters the scene tree for the first time.
var PlayerRoot
var player
var ItemAtual: int = 0
@onready var ImgFala = $TextureRect
@onready var nomefalante: Label = $VBoxContainer/NomeFalante
@onready var falaTexto: RichTextLabel = $VBoxContainer/PanelContainer/MarginContainer/FalaTexto
@export var DialogueData: diagData

@onready var OptButtonPreload = preload("res://Interação/Chatting/option_button.tscn")
var proxima_Etapa = true
func _ready() -> void:
	player = get_tree().get_first_node_in_group("PLAYER").get_child(0)
	player.interagindo = true
	pass # Replace with function body.
# Called every frame. 'delta' is the elapsed time since the previous frame.

func _process(delta: float) -> void:
	if ItemAtual >=  DialogueData.Conversas[0].falas.size():
		player.interagindo = false
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		queue_free()
	if proxima_Etapa:
		print(ItemAtual)
		proxima_Etapa = false
		var item
		if DialogueData.DialogoRng:
			item = DialogueData.Conversas[randi_range(DialogueData.diagRandomStart,DialogueData.diagRandomEnd)]
			print(item)
		else:
			item = DialogueData.Conversas[DialogueData.primeiroDialogo]
		if item.falas[ItemAtual] is TextData:
			Dialogo()
		elif item.falas[ItemAtual] is EscolhaDiagSize:
			Escolha()
	
	pass

func Funcao() -> void:
	pass
func Escolha() -> void:
	pass
func Dialogo() -> void:
	
	if DialogueData.Conversas[0].falas[ItemAtual].FalanteImg:
		ImgFala.texture =DialogueData.Conversas[0].falas[ItemAtual].FalanteImg
		#ImgFala.offset.y = DialogueData.Conversas[0].falas[ItemAtual].FalanteImg.get_size().y
	falaTexto.text = DialogueData.Conversas[0].falas[ItemAtual].texto
	nomefalante.text =DialogueData.Conversas[0].falas[ItemAtual].FalanteNome
	while  true:
		await  get_tree().process_frame
		if Input.is_action_just_pressed("interagir"):
			ItemAtual += 1
			proxima_Etapa = true
