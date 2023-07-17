extends Camera3D

@export var lerp_speed = 10.0
@export var target_path : NodePath
@export var offset = Vector3.ZERO
var mouseDelta = Vector2()
var sensitivity = 0.2
var invertY = false
var camera_anglev = 0
var pitch = 0
var yaw = 0
var translation_speed = 0.1

var target = null

func _ready():
	if target_path:
		target = get_node(target_path)
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	set_process_input(true)

func _input(event):
	if event is InputEventMouseMotion:
		var mouse_delta = event.relative
		yaw -= mouse_delta.x * sensitivity
		pitch -= mouse_delta.y * sensitivity
		pitch = clamp(pitch, -90, 90)
		set_rotation_degrees(Vector3(pitch, yaw, 0))
		#mouseDelta = event.relative

func _physics_process(delta):
	if !target:
		return

	var target_xform = target.global_transform.translated_local(offset)
	global_transform = global_transform.interpolate_with(target_xform, lerp_speed * delta)

	look_at(target.global_transform.origin, target.transform.basis.y)	
	
	

