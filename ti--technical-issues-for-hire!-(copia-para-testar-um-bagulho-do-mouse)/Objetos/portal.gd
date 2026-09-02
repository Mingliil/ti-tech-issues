extends Node3D

@export var siblingPortal: Node
var player
@onready var viewportTexture:SubViewport = $SubViewport
@onready var PortalMesh: MeshInstance3D = $PortalMesh



func _ready() -> void:
	player = get_tree().get_first_node_in_group("PLAYER")


func _process(delta: float) -> void:
	pass
