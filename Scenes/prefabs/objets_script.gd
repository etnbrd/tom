extends StaticBody3D

@export var chara_name:String
@export var face:CompressedTexture2D
func _ready() -> void:
	$icon_talk.visible=false
	$icon_talk/Label3D.text=chara_name
func _on_area_3d_area_entered(area: Area3D) -> void:
	if(area.is_in_group("player")):
		var player=area.get_parent()
		player.contact=chara_name
		#if face:
			#player.get_parent().face=face
		$icon_talk.visible=true

func _on_area_3d_area_exited(area: Area3D) -> void:
	if(area.is_in_group("player")):
		area.get_parent().contact=""
		area.get_parent().face=null

		area.get_parent().action()
		$icon_talk.visible=false
