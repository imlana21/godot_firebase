extends Control

var is_popup: bool = false

func _on_play_button_pressed() -> void:
	if is_popup:
		hide()
		var MenuBtn = get_parent().get_parent().find_children('ButtonList')[0]
		MenuBtn.show()
	else:
		get_tree().change_scene_to_file("res://project/main.tscn")

func show_popup() -> void:
	show()
	is_popup = true

func _on_show_2nd_menu_button_pressed():
	if is_popup:
		hide()
		get_parent().find_child('SecondMenu').show_popup()
	else:
		get_tree().change_scene_to_file("res://project/popup/second_menu/menu.tscn")

func _on_wheel_pressed():
	if is_popup:
		hide()
		get_parent().find_child('WheelPopup').show_popup()
	else:
		get_tree().change_scene_to_file("res://project/popup/wheel/wheel.tscn")	
