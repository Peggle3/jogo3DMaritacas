extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if AudioServer.get_bus_volume_db(0) > 0 :
		if(Global.player_pos.distance_to(position) <= 15):
			get_tree().reload_current_scene()
	pass
