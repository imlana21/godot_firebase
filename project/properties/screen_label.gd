extends Control

var pen_grid_count: int = 0
var mouse_clicked: bool = false
var label_value: int = 0
# var is_point_claimed: bool = false

func _input(event: InputEvent):
	if event is InputEventMouseButton:
		mouse_clicked = event.pressed

func _ready():
	pen_grid_count = 0

func set_text_number(number: int):
	label_value = number
	$Label.text = str(number).pad_zeros(3)

func inc_pen_grid_count():
	if mouse_clicked:
		pen_grid_count += 1
		if pen_grid_count == 80:
			Game.player_point += label_value
			print("Point : " + str(Game.player_point))
			print(Game.player_data)

func reset():
	pen_grid_count = 0
	mouse_clicked = false	
	label_value = 0
	for detector in $PenDetector.get_children():
		detector.panel_clicked = false