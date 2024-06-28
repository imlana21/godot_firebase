extends Control

func _on_button_pressed():	
	Firebase.Auth.logout()
	get_tree().change_scene_to_file("res://project/auth.tscn")
