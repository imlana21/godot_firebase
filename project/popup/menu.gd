extends Control

var is_popup: bool = false

func _process(_delta) -> void:
	check_point()
	if $TimeList/RandomCoin.is_stopped():
		$Bottom/RandomCoinTimer.text = ''
		$Bottom/Minus10KButton.disabled = false
	else:
		$Bottom/RandomCoinTimer.text = seconds_to_minutes($TimeList/RandomCoin.time_left) + ' Time Left'
		$Bottom/Minus10KButton.disabled = true

func _on_play_button_pressed() -> void:
	if is_popup:
		hide()
		var MenuBtn = get_parent().get_parent().find_children('ButtonList')[0]
		MenuBtn.show()
	else:
		get_tree().change_scene_to_file("res://project/main.tscn")

func _on_minus_10k_button_pressed() -> void:
	Game.player_data.point -= 10000
	Game.update_database()

func show_popup() -> void:
	show()
	is_popup = true

func check_point() -> void:
	if Game.player_data.point >= 10000:
		$Bottom/Minus10KButton.disabled = false
	else:
		$Bottom/Minus10KButton.disabled = true

func _on_random_coin_button_pressed() -> void:
	# _on_play_button_pressed()
	var reward: float = randf_range(0.0, 0.1)
	var notif: Control = get_parent().find_children('Notification')[0]
	Game.player_data.coin += reward
	Game.update_database()
	notif.set_reward(reward)
	$TimeList/RandomCoin.start()

func seconds_to_minutes(time_sec) -> String:
	var minutes = floor(time_sec / 60)
	var seconds = int(time_sec) % 60
	return "%02d:%02d" % [minutes, seconds]