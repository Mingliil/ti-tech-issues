extends Node3D

var TextoInte
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	TextoInte = get_node("Label3D")
	
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	pass


func _on_area_3d_area_entered(area: Area3D) -> void:
	TextoInte.text = "aperte E para interagir"
	add_to_group("Player")

func _on_area_3d_area_exited(area: Area3D) -> void:
	remove_from_group("Player")
	TextoInte.text = ""
	
func _on_player_interact(Interact: Variant) -> void:
	if is_in_group("Player"):
		print("foi")
		if Interact == 1:
			var afonso = get_node("AFONSO")
			if afonso.visible == false:
				afonso.visible = true
			else:
				afonso.visible = false
