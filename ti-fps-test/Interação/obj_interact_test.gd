extends RigidBody3D

@onready var modelo: MeshInstance3D = $Mesh

@export var obj_vars: Array[UniResExpo]
signal interact
const textBox = preload("res://Interação/Chatting/text_box.tscn")


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	interact.connect(on_interact)
	
	pass # Replace with function body.
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
		
func on_interact() -> void:
	
	if obj_vars.size() == 2:	
		var dialogueBox = textBox.instantiate()
		dialogueBox.FalaData = obj_vars[1]
		get_tree().root.add_child(dialogueBox)
		#ChattingManager.Begin_Chat(obj_vars[1])
	print(obj_vars.size())
