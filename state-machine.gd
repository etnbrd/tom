extends Node

var scenario_path = "res://Scenario/tom.csv"
var scenario
var state_index = 0

func _ready():
	scenario = parse_scenario(scenario_path)
#
func parse_scenario(filePath):
	var file = FileAccess.open(filePath, FileAccess.READ)	
	
	if file == null:
		print("unable to scenario file at ", filePath)
		return "stuffs"
	
	var states = []
	var threads = []
	var id_key = ""
	while not file.eof_reached():
		var line = file.get_csv_line(",")

		var key = line.get(0)
		var values = line.slice(1)
		
		# discard empty lines
		if values.size() == 0:
			continue
		
		if id_key == "":
			id_key = key
		
		# Initialize threads
		if threads.size() == 0:
			for i in range(values.size()):
				threads.append({
					key: values[i],
					"states": [],
				})

		# fill in threads
		for i in range(threads.size()):
			var thread = threads[i]
			var value = values[i]
			if key == "":
				thread["states"].append(value)
			else:
				thread[key] = values[i]
		
	# Turn the list of threads into the key-based scenario
	var scenario = {}
	for thread in threads:
		var key = thread[id_key]
		scenario[key] = thread
		pass
		
	file.close()
	return scenario

func get_thread_meta(thread_name: String, key: String) -> String:
	if !scenario.has(thread_name):
		print("scenario has no thread named ", thread_name)
		return ""
	
	var thread = scenario[thread_name]
	if !thread.has(key):
		print("thread ", thread_name, " has no key ", key)
		return ""
		
	return thread[key]
		

func get_state(thread_name: String) -> String:
	
	if !scenario.has(thread_name):
		return "..."
	
	var thread = scenario[thread_name]
	if thread == null:
		return "..."
		
	var state = thread["states"][state_index]

	if state == "update":
		state_index += 1
		return get_state(thread_name)
	
	return state
