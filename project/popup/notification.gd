extends Control

signal notif_closed

func set_reward(
	reward: float,
	title: String = 'Congratulations !!!',
	content: String = 'Coin',
	is_float: bool = true
) -> void:
	if is_float:
		$Reward.text = str('%.4f' % reward)
	else:
		$Reward.text = str(reward)
	$Congratulation.text = title
	$Label.text = content
	show()

func _on_close_button_pressed() -> void:
	notif_closed.emit()
	hide()