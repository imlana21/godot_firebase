extends Control

func set_reward(reward: float):
	$Reward.text = str('%.4f' % reward)
	show()

func _on_close_button_pressed():
	hide()