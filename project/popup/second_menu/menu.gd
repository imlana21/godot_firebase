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

func _on_random_coin_button_pressed() -> void:
	# _on_play_button_pressed()
	var reward: float = randf_range(0.0, 0.1)
	var notif: Control = get_parent().find_children('Notification')[0]
	Game.player_data.coin += reward
	Game.update_database()
	notif.set_reward(reward)
	$TimeList/RandomCoin.start()
	
#unused
func seconds_to_minutes(time_sec) -> String:
	var minutes = floor(time_sec / 60)
	var seconds = int(time_sec) % 60
	return "%02d:%02d" % [minutes, seconds]

func _process(_delta) -> void:
	if $TimeList/RandomCoin.is_stopped():
		$Bottom/RandomCoinTimer.text = ''
	else:
		$Bottom/RandomCoinTimer.text = seconds_to_minutes($TimeList/RandomCoin.time_left) + ' Time Left'