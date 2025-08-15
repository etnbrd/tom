extends TextureButton

@export var button_name: String
@export var function: Callable

func _ready():
	$"Label".text = button_name

func _on_focus():
	$Label.add_theme_color_override("font_color", "ff0000")
	
func _on_blur():
	$Label.add_theme_color_override("font_color", "ffffff")
