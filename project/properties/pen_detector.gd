extends Panel

var panel_clicked: bool = false

func _gui_input(event):
	if OS.get_name() == "Android":
		if event is InputEventScreenTouch or event is InputEventScreenDrag:
			panel_clicked = true
			get_parent().get_parent().inc_pen_grid_count()

func _on_mouse_exited():
	panel_clicked = true

func _on_mouse_entered():
	if !panel_clicked:
		get_parent().get_parent().inc_pen_grid_count()
