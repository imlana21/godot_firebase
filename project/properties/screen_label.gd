extends Control

var pen_grid_count: int = 0
var mouse_clicked: bool = false
var label_value: int = 0
var fruit_list: Array = [
	{
		'name': 'apple',
		'start_range': 1,
		'end_range': 100,
		'percent': 0
	},
	{
		'name': 'orange',
		'start_range': 100,
		'end_range': 200,
		'percent': 0
	},
	{
		'name': 'watermelon',
		'start_range': 200,
		'end_range': 300,
		'percent': 0
	},
	{
		'name': 'lime',
		'start_range': 300,
		'end_range': 400,
		'percent': 75
	},
	{
		'name': 'strawberry',
		'start_range': 400,
		'end_range': 500,
		'percent': 25
	},
]
var max_pen_grind: int = 0

func _input(event: InputEvent):
	if event is InputEventMouseButton and !Game.prevent_mouse:
		mouse_clicked = event.pressed

func _ready():
	pen_grid_count = 0
	max_pen_grind = round($PenDetector.get_child_count() * 0.6)
	var menu_popup = get_parent().find_child('MenuPopUp')
	if menu_popup:
		menu_popup.find_child('Notification').connect('notif_closed', set_label)
	else:
		set_label()

func inc_pen_grid_count():
	if mouse_clicked and !Game.prevent_mouse:
		pen_grid_count += 1
		if pen_grid_count == max_pen_grind:
			if Game.level_up(label_value):
				Game.prevent_mouse = true
				get_parent().clear_canvas()
				await get_tree().create_timer(2).timeout
				get_parent().find_child('MenuPopUp').find_child('Notification').set_reward(Game.player_data.level, 'Level Up', '+' + str(label_value), false)
			else:
				Game.prevent_mouse = true
				get_parent().clear_canvas()
				await get_tree().create_timer(2).timeout
				get_parent().find_child('MenuPopUp').find_child('Notification').set_reward(Game.player_data.level, '', '+' + str(label_value), false)

func reset():
	pen_grid_count = 0
	mouse_clicked = false
	label_value = 0
	Game.prevent_mouse = false
	for detector in $PenDetector.get_children():
		detector.panel_clicked = false

func set_label():
	reset()
	var random_fruit = get_random_name()
	get_parent().init_canvas()
	$TextureRect.texture = load('res://assets/img/fruit/' + random_fruit.name + '.png')
	label_value = randi_range(random_fruit.start_range, random_fruit.end_range)

func get_random_name() -> Dictionary:
	var total_percent = 0
	for fruit in fruit_list:
		total_percent += fruit['percent']
    
	var random_value = randi() % total_percent
	var cumulative_percent = 0
    
	for fruit in fruit_list:
		cumulative_percent += fruit['percent']
		if random_value < cumulative_percent:
			return fruit
	return {}