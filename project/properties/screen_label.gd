extends Control

func set_label_text(text: String):
	$Label.text = text

func _on_label_gui_input(event:InputEvent):
	print(event)
