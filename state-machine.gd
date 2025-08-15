extends Node

var text_file_path = "res://Scenario/tom.csv"

func _ready():
	var text_content = get_text_file_content(text_file_path)
	print("text_content", text_content)
#
func get_text_file_content(filePath):
	print("file path", filePath)
	var file = FileAccess.open(filePath, FileAccess.READ)	
	print("file", file)
	
	if file == null:
		print("unable to open csv file at ", text_file_path)
		return "stuffs"
	
	var states = []
	#while not file.eof_reached():
		#var line = file.get_csv_line(",")
		#print("content", line)
		##states = 
		
	#file.close()
	
	return "stuffs"


var state_index = 0

var states = [
	{
		"Sylvie": "j'attend une livraison de quelque chose mais à la place, j'ai reçu autre chose... je suis embêtée, je ne sais pas quoi faire avec... Bonne journée !",
		"Giles": "update",
		"Nico": "excel c'est excellent",
		"Bob": "j'adore le lundi...",
		"Claire": "ce travaille je pourrais le faire pour gratuit, mais je suis mal payé, quel imbécile ce patron",
		"Porte": "closed",
	},
	{
		"Sylvie": "oh lala tom je sais pas ou il est",
		"Giles": "ca fait un moment qu'on n'a pas vu tom oui ?",
		"Nico": "Tom.. le stagiaire ? pas vu",
		"Bob": "tom, il aime le lundi aussi, mais son jour préféré c'est le mardi",
		"Claire": "update",
		"Porte": "closed",
	},
]


func get_state(thread_name: String) -> String:
	var state = states[state_index]
	if state == null:
		return "..."

	if !state.has(thread_name):
		return "..."
		
	var cell = state[thread_name]
	
	if cell == null or cell == "":
		return "..."
	
	if cell == "update":
		state_index += 1
		return get_state(thread_name)
	
	return cell
