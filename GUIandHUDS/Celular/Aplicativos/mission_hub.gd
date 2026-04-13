extends Control

var celular: CanvasLayer
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	celular = get_tree().root.get_node("Celular")
	celular.missao_botao()
	ajeitar_botoes()

func ajeitar_botoes() -> void:
	
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
