extends HBoxContainer

signal btn_setting_pressed

func _process(_delta):
	$Poin/Label.text = str(Game.player_data.point) + "/" + str(Game.player_data.max_point)
	if Game.player_data.coin > 0:
		$Coin/Label.text = str('%.2f' % Game.player_data.coin)
	else:
		$Coin/Label.text =  '0'

func _on_texture_button_pressed():
	btn_setting_pressed.emit()
