@tool
extends SubViewport


# Called when the node enters the scene tree for the first time.
func _ready():
	get_parent().transparent = true
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	size = $Label.size
	pass
