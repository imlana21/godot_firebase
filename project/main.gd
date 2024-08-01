extends Control

var mouse_pressed: bool = false
var curr_line: Line2D
var registered_number: Array = []
var brush_size: int = 25
var brush_color: Color = Color(1, 1, 1, 0)
var image: Image
var texture: ImageTexture

func _ready() -> void:
	$AnimationPlayer.play('default')
	$ScreenLabel.reset()
	$ScreenLabel.set_label()

func _input(event) -> void:
	if OS.get_name() == "Android":
		if event is InputEventScreenTouch or event is InputEventScreenDrag:
			var local_pos = $PenCanvas.get_local_mouse_position()
			$Debugger.text = str(local_pos)
			draw_on_canvas(Vector2i(local_pos.x, local_pos.y))
	else:
		if event is InputEventMouseButton:
			mouse_pressed = event.pressed
		if event is InputEventMouseMotion and mouse_pressed:
			draw_on_canvas($PenCanvas.get_local_mouse_position())

func _on_menu_button_pressed() -> void:
	$ButtonList.hide()
	$MenuPopUp/Menu.show_popup()

func init_canvas(with_color: Color = Color(0, 0, 0, 1)) -> void:
	# default color is black
	image = Image.create(int($PenCanvas.size.x), int($PenCanvas.size.y), false, Image.FORMAT_RGBA8)
	image.fill(with_color)
	texture = ImageTexture.create_from_image(image)
	$PenCanvas.texture = texture

func clear_canvas() -> void:
	init_canvas(Color(1, 1, 1, 0))

func draw_on_canvas(pos: Vector2i) -> void:
	if $PenCanvas.texture:
		for i in range(-brush_size, brush_size):
			for j in range(-brush_size, brush_size):
				var dist = sqrt(i * i + j * j)
				if dist < brush_size:
					var pixel_pos = Vector2i(pos.x + i, pos.y + j)
					if pixel_pos.x >= 0 and pixel_pos.x < image.get_width() and pixel_pos.y >= 0 and pixel_pos.y < image.get_height():
						image.set_pixelv(pixel_pos, brush_color)
		texture = ImageTexture.create_from_image(image)
		$PenCanvas.texture = texture

func _on_currencies_btn_setting_pressed():
	$MenuPopUp/Setting.show_setting()
