extends Control

var pen_grid_count: int = 0
var mouse_clicked: bool = false
var label_value: int = 0

func _input(event: InputEvent):
	if event is InputEventMouseButton and !Game.prevent_mouse:
		mouse_clicked = event.pressed

func _ready():
	pen_grid_count = 0

func set_text_number(number: int):
	reset()
	label_value = number
	$Label.text = str(number).pad_zeros(3)

func inc_pen_grid_count():
	if mouse_clicked and !Game.prevent_mouse:
		pen_grid_count += 1
		if pen_grid_count == 70:
			print(label_value)
			if Game.level_up(label_value):
				Game.prevent_mouse = true
				print_debug("Level Up")
				get_parent().find_child('MenuPopUp').find_child('Notification').set_reward(Game.player_data.level, 'Level Up', '', false)
				await get_tree().create_timer(3).timeout
				get_parent().init_canvas()
				set_text_number(randi_range(1, 300))
			else:
				Game.prevent_mouse = true
				await get_tree().create_timer(4).timeout
				get_parent().init_canvas()
				set_text_number(randi_range(1, 300))


func reset():
	pen_grid_count = 0
	mouse_clicked = false	
	label_value = 0
	Game.prevent_mouse = false
	for detector in $PenDetector.get_children():
		detector.panel_clicked = false