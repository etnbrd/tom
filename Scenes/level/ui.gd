extends Control

var thread: Dictionary

func _ready() -> void:
	state_machine.state_updated.connect(_on_update_state)
	thread = state_machine.get_thread("quest")
	_on_update_state(0)

	$Interaction.visible = false

func display_interaction(label: String, content: String, icon: CompressedTexture2D) -> void:
	$Interaction/label.text = label
	$Interaction/content.text = content
	$Interaction/icon.texture = icon
	$Interaction.visible = true
	
func clear_interaction() -> void:
	$Interaction.visible = false
	
func update_quest(label: String) -> void:
	$Quest/label.text = label

func _on_update_state(state_index: int) -> void:
	self.update_quest(thread.states[state_index])
