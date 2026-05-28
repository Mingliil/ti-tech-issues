extends Node


func reparentNode(Nde: Node, NewParent) -> void:
	Nde.reparent(NewParent, true)
