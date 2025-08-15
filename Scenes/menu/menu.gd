extends Control

func _ready():
	$"MarginContainer/HBoxContainer/VBoxContainer/Chercher Tom".connect("pressed", start_game)
	$"MarginContainer/HBoxContainer/VBoxContainer/Démissionner".connect("pressed", quit)
	
func start_game():
	get_tree().change_scene_to_file("res://Scenes/level/main.tscn")
	
func quit():
	quit()
