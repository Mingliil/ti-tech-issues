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

func _ready() -> void:
	player = get_tree().get_first_node_in_group("PLAYER").get_child(0)
	player.interagindo = true
	pass # Replace with function body.
# Called every frame. 'delta' is the elapsed time since the previous frame.

func _process(delta: float) -> void:
	if ItemAtual+1 >  DialogueData.Conversas[0].falas.size():
		player.interagindo = false
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		queue_free()
	
	else:
		if DialogueData.Conversas[0].falas[ItemAtual].FalanteImg:
			ImgFala.texture =DialogueData.Conversas[0].falas[ItemAtual].FalanteImg
			#ImgFala.offset.y = DialogueData.Conversas[0].falas[ItemAtual].FalanteImg.get_size().y
		falaTexto.text = DialogueData.Conversas[0].falas[ItemAtual].texto
		nomefalante.text =DialogueData.Conversas[0].falas[ItemAtual].FalanteNome
	if Input.is_action_just_pressed("interagir"):
		ItemAtual +=1
	pass
	
