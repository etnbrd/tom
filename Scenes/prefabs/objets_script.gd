extends StaticBody3D

@export var chara_name:String
@export var face:CompressedTexture2D
func _ready() -> void:
	$icon_talk.visible=false
	$icon_talk/Label3D.text=chara_name
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
		#
	$"../UI/Panel".visible=false

func interact() -> void:
	var action = state_machine.get_state(chara_name)
	
	$"../UI/Panel/talk".text = action
	$"../UI/Panel/name".text = chara_name
	$"../UI/Panel/TextureRect".texture = face

	$"../UI/Panel".visible=true
