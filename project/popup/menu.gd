extends Control

func _ready():
	if Game.player_point >= 10000:
		$VBoxContainer/Minus10KButton.disabled = false
	else:
		$VBoxContainer/Minus10KButton.disabled = true

func _on_log_out_button_pressed() -> void:
	Firebase.Auth.logout()
	get_tree().change_scene_to_file("res://project/auth.tscn")

func _on_play_button_pressed() -> void:
	hide()
	var MenuBtn = get_parent().get_parent().find_children('ButtonList')[0]
	MenuBtn.show()

func _on_minus_10k_button_pressed() -> void:
	Game.player_point -= 10000

func check_point() -> void:
	if Game.player_point >= 10000:
		$VBoxContainer/Minus10KButton.disabled = false
	else:
		$VBoxContainer/Minus10KButton.disabled = true