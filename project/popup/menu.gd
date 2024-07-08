extends Control

func _ready():
	if Game.player_point >= 10000:
		$VBoxContainer/Minus10KButton.disabled = false
	else:
		$VBoxContainer/Minus10KButton.disabled = true

func _process(_delta) -> void:
	if $TimeList/RandomCoin.is_stopped():
		$VBoxContainer/RandomCoinButton.text = "Random Coin"
		$VBoxContainer/RandomCoinButton.disabled = false
	else:
		$VBoxContainer/RandomCoinButton.text = seconds_to_minutes($TimeList/RandomCoin.time_left)
		$VBoxContainer/RandomCoinButton.disabled = true

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

func _on_random_coin_button_pressed() -> void:
	Game.player_coin += randf_range(0.01, 0.10)
	_on_play_button_pressed()
	$TimeList/RandomCoin.start()

func seconds_to_minutes(time_sec) -> String:
	var minutes = floor(time_sec / 60)
	var seconds = int(time_sec) % 60
	return "%02d:%02d" % [minutes, seconds]