extends Control


@onready var exitButton: Button=$SairDoJogo




func _on_sair_do_jogo_pressed() -> void:
	get_tree().quit()
	pass # Replace with function body.
