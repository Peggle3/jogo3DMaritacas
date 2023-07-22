extends CSGBox3D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(Global.rotation_value > 1 and Global.rotation_value < 1.4):
		use_collision = false
	else:
		use_collision = true
	#if(get_tree().get_first_node_in_group("Jorginquebracod").rotation_degrees == 180):
		#print("A")
	pass
