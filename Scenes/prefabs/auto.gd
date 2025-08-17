extends Node3D

@export var exist:String

func _ready() -> void:
	state_machine.state_updated.connect(_on_update_state)
	_on_update_state(0)

func _on_update_state(state_index: int) -> void:
	# Avoid crashing at the end of the game
	if ( is_in_range(state_index,exist)):
		if(visible!=true):
			for child in get_children():
				if child is Light3D:
					var energy=child.light_energy
					child.light_energy=0
					var tween = create_tween()
					tween.tween_property(child, "light_energy", energy, 1.0)
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
