extends Control

func _on_log_out_button_pressed():
	Firebase.Auth.logout()
	get_tree().change_scene_to_file("res://project/auth.tscn")

func _on_play_button_pressed():
	hide()
	var MenuBtn = get_parent().get_parent().find_children('ButtonList')[0]
	MenuBtn.show()