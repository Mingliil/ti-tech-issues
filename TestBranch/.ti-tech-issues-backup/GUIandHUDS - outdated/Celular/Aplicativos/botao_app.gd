extends PanelContainer

@export var aplicativoAba: PackedScene
@export var aplicativoNome: String
@onready var nome = $Vbox/Label
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	nome.text = aplicativoNome
	
	pass # Replace with function body.

func _pressed() -> void:
	var celular:CanvasLayer = get_tree().root.get_node("Celular")
	celular.mude_app_aba(aplicativoAba)
	pass # Replace with function body.
