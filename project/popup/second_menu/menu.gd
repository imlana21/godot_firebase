extends Control

var is_popup: bool = false

# Back Button
func _on_play_button_pressed() -> void:
	if is_popup:
		hide()
		get_parent().find_child('Menu').show_popup()		
	else:
		get_tree().change_scene_to_file("res://project/popup/main_menu/menu.tscn")

func show_popup() -> void:
	show()
	is_popup = true

func _on_minus_10k_button_pressed():
	Game.player_data.coin -= 10000
	Game.update_database()