extends Node3D

var camrot_h = 0.0
var camrot_v = 0.0
var cam_v_max = 75
var cam_v_min = -55
var h_sensitivity = 0.1
var v_sensitivity = 0.1
var h_acceleration = 10
var v_acceleration = 10

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	#$h/v/Camera3D.add_exception(get_parent())
	
func _input(event):
	if event is InputEventMouseMotion:
		
		#$Camroot.get_parent().rotate_y(deg_to_rad(-event.relative.x * h_sensitivity))
		$mouse_control_stay_delay.start()
		camrot_h += -event.relative.x * h_sensitivity
		camrot_v += event.relative.y * v_sensitivity
		#$h.get_parent_node_3d().get_parent_node_3d().rotate_y(deg_to_rad(-event.relative.x * h_sensitivity))
		
func _physics_process(delta):
	
	camrot_v = clamp(camrot_v, cam_v_min, cam_v_max)
	
	var mesh_front = get_node("../MeshInstance3D").global_transform.basis.z
	var rot_speed_multiplier = 0.15 #se diminui isso aq aumenta o raio de rotacao
	var auto_rotate_speed =  (PI - mesh_front.angle_to($h.global_transform.basis.z)) * get_parent().velocity.length() * rot_speed_multiplier
	
	if $mouse_control_stay_delay.is_stopped():
		#SEGUE A CAMERA
		$h.rotation.y = lerp_angle($h.rotation.y, get_node("../MeshInstance3D").global_transform.basis.get_euler().y, delta * auto_rotate_speed)
		camrot_h = $h.rotation_degrees.y
	else:
		#CAMERA NO MOUSE
		$h.rotation_degrees.y = lerpf($h.rotation_degrees.y, camrot_h, delta * h_acceleration)
	
	$h/v.rotation_degrees.x = lerpf($h/v.rotation_degrees.x, camrot_v, delta * v_acceleration)
	
