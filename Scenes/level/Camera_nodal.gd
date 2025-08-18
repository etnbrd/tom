extends Node3D

@export var follow:Node3D
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	position=follow.position
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position=lerp(position,follow.position,3*delta)
