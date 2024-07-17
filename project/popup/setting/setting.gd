extends Control

func _on_btn_close_pressed():
	hide_setting()

func _on_btn_logout_pressed():
	Firebase.Auth.logout()
	get_tree().change_scene_to_file("res://project/auth.tscn")	

func hide_setting():
	$AnimationPlayer.play('hide')


func show_setting():
	$AnimationPlayer.play('show')