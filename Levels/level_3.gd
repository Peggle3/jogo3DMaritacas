extends Node3D


func _ready():
	save_game()
	
	

func save():
	var save_dict = {}
	
	return save_dict
	
	

func save_game():
	var save_game = FileAccess.open("user://savegame.save", FileAccess.WRITE)
	
	#var json_string = JSON.stringify(save())
	
	#save_game().store_line(json_string)
	
	

func load_game():
	if not FileAccess.file_exists("user://savegame.save"):
		return
	
	
