extends Panel

var panel_clicked: bool = false

func _on_mouse_exited():
	panel_clicked = true

func _on_mouse_entered():
	if !panel_clicked:
		get_parent().get_parent().inc_pen_grid_count()
