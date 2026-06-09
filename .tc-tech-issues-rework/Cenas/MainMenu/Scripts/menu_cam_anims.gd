extends AnimationPlayer

@onready var cam: Camera3D = $"../MainPart/MenuCam"
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	current_animation = "res://Blender/Animations/CameraActionExpt.res"
	play(current_animation)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	pass
