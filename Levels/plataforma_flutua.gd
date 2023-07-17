extends CSGBox3D
var original_pos = position.y


func _input(event):
	if Input.is_action_pressed("Spacebar") && event is InputEventMouseMotion:
		position.y = move_toward(position.y, position.y + 0.01, 50)
		
# Called when the node enters the scene tree for the first time.
func _ready():	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(position.y > original_pos && not Input.is_action_pressed("Spacebar")):
			position.y = move_toward(position.y, position.y - 0.01, 50)
	pass
