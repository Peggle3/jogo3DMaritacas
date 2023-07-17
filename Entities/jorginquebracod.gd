extends CharacterBody3D


const SPEED = 5.0
const JUMP_VELOCITY = 4.5
const sensitivity = 0.1


# Gravidade do projeto
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

#func _input(event):
	#if event is InputEventMouseMotion:
	#	rotate_y(deg_to_rad(-event.relative.x * sensitivity))
	
	

func _physics_process(delta):
	var h_rot = $Camroot/h.global_transform.basis.get_euler().y
	#$MeshInstance3D.rotation.y = lerp_angle($MeshInstance3D.rotation.y, $Camroot/h.rotation.y, delta * 10)
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Handle Jump.
	if Input.is_action_just_pressed("Spacebar") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	#to usando o .rotated(-h_rot) q vai fazer o player ir mais rapido se ele anda com duas direcoes simultaneas
	#da pra arruma colocando um .normalized mas como o jogo eh pra ser cagado acho q vo deixa
	var input_dir = Input.get_vector("Left", "Right", "Front", "Back").rotated(-h_rot)
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		$MeshInstance3D.rotation.y = lerp_angle($MeshInstance3D.rotation.y, $Camroot/h.rotation.y, delta * 10)
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()
