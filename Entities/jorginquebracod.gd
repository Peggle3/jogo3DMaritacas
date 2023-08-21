extends CharacterBody3D

var direction 
var h_rot
const SPEED = 5.0
const JUMP_VELOCITY = 4.5
const sensitivity = 0.1


# Gravidade do projeto
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
#func _input(event):
	#if event is InputEventMouseMotion:
	#	rotate_y(deg_to_rad(-event.relative.x * sensitivity))
	
	
	

func _physics_process(delta):
	Global.player_pos = position
	h_rot = $Camroot/h.global_transform.basis.get_euler().y
	if is_on_floor():
		Global.rotation_value = $Camroot/h/v.global_transform.basis.get_euler().x
	else:
		Global.rotation_value = 0
	
	#$MeshInstance3D.rotation.y = lerp_angle($MeshInstance3D.rotation.y, $Camroot/h.rotation.y, delta * 10)
	
	
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Handle Jump.
	if Input.is_action_just_pressed("Spacebar") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		
	#to usando o .rotated(-h_rot) q vai fazer o player ir mais rapido se ele anda com duas direcoes simultaneas
	#da pra arruma colocando um .normalized mas como o jogo eh pra ser cagado acho q vo deixa
	var input_dir = Input.get_vector("Left", "Right", "Front", "Back").rotated(-h_rot)
	direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	
	if direction:
		if $Timer_audio.time_left <= 0 and is_on_floor():
			$AudioStreamPlayer.pitch_scale = randf_range(1.99,3)
			$AudioStreamPlayer.play()
			$Timer_audio.start(0.6)
		$MeshInstance3D.rotation.y = lerp_angle($MeshInstance3D.rotation.y, $Camroot/h.rotation.y, delta * 10)
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()




func _unhandled_input(event):
	if event.is_action_pressed("ui_cancel"):
		$PauseMenu.pause()
