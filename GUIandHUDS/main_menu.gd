extends Control
@onready var iniciarJogo: Button = $AreaMenu/Button
@onready var testWorld = preload("res://Cenarios/test world.tscn")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	pass


func _on_button_pressed() -> void:
	get_parent()._load_scene(testWorld, Vector3(5,5,5))
	queue_free()
	pass # Replace with function body.
