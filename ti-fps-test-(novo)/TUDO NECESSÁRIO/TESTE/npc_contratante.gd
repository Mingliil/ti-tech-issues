extends RigidBody3D

const DialogueSysPreload = preload("uid://dw1ecymh86dyb")
const ContractPreload = preload("uid://pk11td747jl6")

@export var dialogue: Array[DE]
@export var obj_vars:UniResExpo
@export var Contracts: Array[ContractInfo]
var teste: Signal
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
@warning_ignore("unused_parameter")
func _process(delta: float) -> void:
	pass
func _diag_start() -> void:
	var new_dialogue = DialogueSysPreload.instantiate()
	new_dialogue.dialogue = dialogue
	get_parent().add_child(new_dialogue)
	
func start_shop() -> void:
	print(dialogue)
	teste.emit()
