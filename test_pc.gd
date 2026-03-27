extends Node3D
var IntArea
var PLAYER
var HUD
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	PLAYER = get_tree().get_first_node_in_group("Player")
	HUD = get_tree().get_first_node_in_group("HUD")
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
# aqui coloca tudo que precisa para quando o personagem entrar
func _on_area_entered(area: Area3D) -> void:
	print("entrou")
	PLAYER.interact.connect(_on_player_interact)
	add_to_group("Player")
	pass

# e aqui para quando ele sair
func _on_area_exited(area: Area3D) -> void:
	remove_from_group("Player")
	pass
func _on_player_interact(Interact: Variant) -> void:
	if is_in_group("Player"):
		
		var chagui = load("res://GUIandHUDS/chat_gui.tscn")
		var chatinsta = chagui.instantiate()
		print(chatinsta)
		HUD.add_child(chatinsta)
		
	pass
