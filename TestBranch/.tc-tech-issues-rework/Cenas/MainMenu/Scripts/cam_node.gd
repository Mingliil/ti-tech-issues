extends Node3D

@onready var timer = $Timer
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass




func _on_timer_timeout() -> void:
	$AnimationPlayer.play("Wobble")
	timer.start(randi_range(3,5)) 
	
	pass # Replace with function body.
