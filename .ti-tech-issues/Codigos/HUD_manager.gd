extends CanvasLayer

var PLAYER
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	PLAYER = get_tree().get_first_node_in_group("Player")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if has_node("ChatGUI"):
		print
		pass
	pass
