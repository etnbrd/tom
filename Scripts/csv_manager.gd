extends Node

const LOCAL_CSV_PATH := "res://csv/scenar_tom.csv"

var dialogue: Dictionary = {}

func _ready():
	load_csv_from_file(LOCAL_CSV_PATH)
	

func load_csv_from_file(path: String) -> void:
	var file := FileAccess.open(path, FileAccess.READ)
	if not file:
		push_error("Failed to open file: %s" % path)
		return

	var csv_text := file.get_as_text()
	file.close()

	var rows := parse_csv_robust(csv_text)
	build_dialogue_dictionary(rows)
func parse_csv_robust(text: String) -> Array:
	var result: Array = []
	var row: Array = []
	var current: String = ""
	var in_quotes: bool = false
	var i := 0
	var length := text.length()

	while i < length:
		var char := text[i]

		if char == '"':
			if in_quotes and i + 1 < length and text[i + 1] == '"':
				current += '"'
				i += 1
			else:
				in_quotes = !in_quotes
		elif char == ',' and not in_quotes:
			row.append(current)
			current = ""
		elif (char == '\n' or char == '\r') and not in_quotes:
			# End of row (handle \r\n and \n)
			if char == '\r' and i + 1 < length and text[i + 1] == '\n':
				i += 1  # Skip \n in \r\n
			row.append(current)
			result.append(row)
			row = []
			current = ""
		else:
			current += char

		i += 1

	# Final value (in case file doesn't end with newline)
	if current != "" or row.size() > 0:
		row.append(current)
		result.append(row)

	return result

func build_dialogue_dictionary(rows: Array) -> void:
	if rows.size() < 2:
		push_error("CSV too small or malformed.")
		return

	var headers = rows[0]  # First row: ["ID", "Alice", "Bob", ...]
	var character_names = headers.slice(1)  # Skip first column ("ID")

	# Initialize dialogue dictionary
	for name in character_names:
		dialogue[name] = []

	for y in range(1, rows.size()):
		var row = rows[y]
		for x in range(1, min(row.size(), character_names.size() + 1)):
			var name = character_names[x - 1]
			dialogue[name].append(row[x])

	# Debug output
	print("--- Dialogue Dictionary ---")
	for name in character_names:
		print(name, ": ", dialogue[name])
