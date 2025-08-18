extends StaticBody3D

@export var thread_name:String
@export var face:CompressedTexture2D

@onready var UI:Control=get_tree().get_root().get_node("Main/UI")

var thread: Dictionary
var character_name: String
var dialogue: String

func _ready() -> void:
	state_machine.state_updated.connect(_on_update_state)
	thread = state_machine.get_thread(thread_name)
	character_name = thread["name"]
	_on_update_state(0)
	
	$icon_talk.visible=false
	$icon_talk/Label3D.text=character_name
	$face.texture=face

func _on_area_3d_area_entered(area: Area3D) -> void:
	if(area.is_in_group("player")):
		var player=area.get_parent()
		#player.object=self
		player.add_contact(self)

func _on_area_3d_area_exited(area: Area3D) -> void:
	if(area.is_in_group("player")):
		var player=area.get_parent()
		player.object=null
		player.loose_contact(self)
	UI.clear_interaction()

#what is happening when you can interract
func talkable(is_talkable:bool)->void:
	if is_talkable:
		$icon_talk.visible=true
	else:
		$icon_talk.visible=false

func _on_update_state(state_index: int) -> void:
	# Avoid crashing at the end of the game
	if (state_index >= thread.states.size()):
		return
	var state = thread.states[state_machine.state_index]
	match state:
		"":
			pass # no update
		"invisible":
			self.process_mode = Node.PROCESS_MODE_DISABLED
			dialogue = ""
			visible=false
		_:
			self.process_mode = Node.PROCESS_MODE_INHERIT
			dialogue = state

func interact() -> void:	
	state_machine.update_state(thread_name)
	UI.display_interaction(
		character_name,
		dialogue,
		face
	)
