extends Node3D

@export var exist:String

func _ready() -> void:
	state_machine.state_updated.connect(_on_update_state)
	#state_machine.state_updated.emit()

func _on_update_state(state_index: int) -> void:
	# Avoid crashing at the end of the game
	if ( is_in_range(state_index,exist)):
		visible=true
	else:
		visible=false

func is_in_range(index: int, range_str: String) -> bool:
	var parts = range_str.split(",")
	for part in parts:
		if "-" in part:
			var bounds = part.split("-")
			if bounds.size() == 2:
				var start = int(bounds[0])
				var end = int(bounds[1])
				if index >= start and index <= end:
					return true
		else:
			if index == int(part):
				return true
	return false
