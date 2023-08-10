extends ColorRect

@onready var animator: AnimationPlayer = $AnimationPlayer

@onready var play_button: Button = find_child("Botao_play")
@onready var restart_button: Button = find_child("Botao_carregar")
@onready var options_button: Button = find_child("Botao_opcoes")
@onready var quit_button: Button = find_child("Botao_sair")
@onready var back_button: Button = find_child("Botao_volta")

func _ready():
	pause()
	AudioServer.set_bus_volume_db(0,30)
	play_button.pressed.connect(start)
	quit_button.pressed.connect(get_tree().quit)
	restart_button.pressed.connect(restart)
	options_button.pressed.connect(opcoes)
	back_button.pressed.connect(volta)
	

func start():
	unpause()
	get_tree().change_scene_to_file("res://Levels/level_tutorial.tscn")

func unpause():
	animator.play("Unpause")
	get_tree().paused = false
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
func pause():
	animator.play("Pause")
	get_tree().paused = true
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	
# Called when the node enters the scene tree for the first time.

func restart():
	animator.play("Unpause")
	get_tree().paused = false
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	get_tree().reload_current_scene()

func opcoes():
	$CenterContainer/PanelContainer/MarginContainer/VBoxContainer.hide()
	$CenterContainer/PanelContainer/MarginContainer/Opcoes.show()
	

func volta():
	$CenterContainer/PanelContainer/MarginContainer/Opcoes.hide()
	$CenterContainer/PanelContainer/MarginContainer/VBoxContainer.show()
# Called every frame. 'delta' is the elapsed time since the previous frame.


func volume(bus_index,value):
	AudioServer.set_bus_volume_db(bus_index,value)
func _process(delta):
	pass


func _on_master_slider_value_changed(value):
	volume(0,value)
	pass # Replace with function body.
