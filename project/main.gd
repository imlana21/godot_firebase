extends Control

@onready var scratch_screen = $ScratchScreen

var registered_number: Array = [10, 11, 20]

func _on_button_pressed():	
	Firebase.Auth.logout()
	get_tree().change_scene_to_file("res://project/auth.tscn")

func _ready():
	$AnimationPlayer.play('default')
	for screen in scratch_screen.get_children():
		screen.connect('screen_clicked', _on_scratch_screen_clicked)

func _on_scratch_screen_clicked(screen: ColorRect):
	if !screen.status:
		var label = load("res://project/properties/screen_label.tscn").instantiate()
		label.set_anchors_preset(Control.PRESET_CENTER_BOTTOM)
		label.scale = Vector2(0.7, 0.7)
		label.set_label_text(get_unique_randomize())
		screen.add_child(label)
		screen.self_modulate = 'ffffff00'
		screen.status = true

func get_unique_randomize():
	var rand_number = randi_range(1, 300)
	while rand_number in registered_number:
		rand_number = randi_range(1, 300)
	registered_number.append(rand_number)
	return str(rand_number)