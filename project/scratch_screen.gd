extends ColorRect

signal screen_clicked

var status: bool = false

func _on_gui_input(_event:InputEvent):
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		screen_clicked.emit(self)
