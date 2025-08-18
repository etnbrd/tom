extends Area3D
@export var where:String

func _on_area_entered(area: Area3D) -> void:
	if(where):
		get_tree().change_scene_to_file(where)
