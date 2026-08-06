extends RigidBody3D

const DialogueSysPreload = preload("uid://dw1ecymh86dyb")


@export var dialogue: Array[DE]
@export var obj_vars:UniResExpo
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
func _shop_Start() -> void:
	print("oi")
	var new_dialogue = DialogueSysPreload.instantiate()
	#lse:
	#	if PLAYER.global_position.y > get_viewport().get_camera_3d().y:
	#		desired_dialogue_pos = dialogue_top_pos
	#	else:
	#		desired_dialogue_pos = dialogue_bottom_pos
	new_dialogue.dialogue = dialogue
	get_parent().add_child(new_dialogue)

func _override_dialogue() -> void:
	pass
