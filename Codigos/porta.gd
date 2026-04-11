extends Node3D

var player: CharacterBody3D


@export var cenaLoad: String = &""
func _on_area_entered(area: Area3D) -> void:
	player = get_tree().get_first_node_in_group("Player")
	if not player.interact.connect(_on_player_interact):
		player.interact.connect(_on_player_interact)
	pass # Replace with function body.


func _on_area_exited(area: Area3D) -> void:
	player.interact.disconnect(_on_player_interact)
	pass # Replace with function body.
	
func _on_player_interact(Interact: Variant) -> void:
	print("porta")
	SceneLoader.load_scene(cenaLoad, Vector3(0,9,0))
	pass
