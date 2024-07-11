extends HBoxContainer

func _process(_delta):
	$Label.text = "Level : " + str(Game.player_data.level)