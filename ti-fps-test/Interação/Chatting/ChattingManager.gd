extends Node





# Called when the node enters the scene tree for the first time.
var PlayerRoot
var player
var ItemAtual: int = 0
@export var FalaData: SpeakerData
func _ready() -> void:
	player = get_tree().get_first_node_in_group("PLAYER").get_child(0)
	player
	print(FalaData.FalanteNome)
	pass # Replace with function body.
# Called every frame. 'delta' is the elapsed time since the previous frame.

func _process(delta: float) -> void:
	if ItemAtual >  FalaData.falas.size():
		pass
	pass
