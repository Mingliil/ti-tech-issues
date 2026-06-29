extends Node

const textBox = preload("res://Interação/Chatting/text_box.tscn")
func beginChatting(og_node) -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	print("chatstart", og_node)
	var dialogueBox = textBox.instantiate()
	dialogueBox.FalaData = og_node.obj_vars[1]
	get_tree().root.add_child(dialogueBox)
