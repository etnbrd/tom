extends Control

func _ready() -> void:
	$Interaction.visible = false
	
	self.update_quest(state_machine.get_state("quest"))

func display_interaction(label: String, content: String, icon: CompressedTexture2D) -> void:
	$Interaction/label.text = label
	$Interaction/content.text = content
	$Interaction/icon.texture = icon
	$Interaction.visible = true
	
func clear_interaction() -> void:
	$Interaction.visible = false
	
func update_quest(label: String) -> void:
	$Quest/label.text = label
