extends StaticBody3D

@export var thread_name:String
@export var face:CompressedTexture2D

var character_name

func _ready() -> void:
	character_name = state_machine.get_thread_meta(thread_name, "name")
	$icon_talk.visible=false
	$icon_talk/Label3D.text=character_name
	$face.texture=face

func _on_area_3d_area_entered(area: Area3D) -> void:
	if(area.is_in_group("player")):
		var player=area.get_parent()
		player.object=self
		$icon_talk.visible=true

func _on_area_3d_area_exited(area: Area3D) -> void:
	if(area.is_in_group("player")):
		var player=area.get_parent()
		player.object=null
		$icon_talk.visible=false

	$"../UI".clear_interaction()

func interact() -> void:	
	$"../UI".display_interaction(
		character_name,
		state_machine.get_state(thread_name),
		face
	)
	
	$"../UI".update_quest(state_machine.get_state("quest"))
