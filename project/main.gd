extends Control

@onready var scratch_screen := $ScratchScreen

var mouse_pressed: bool = false
var curr_line: Line2D
var registered_number: Array = []
var brush_size = 15
var brush_color = Color(1, 1, 1, 0)
var image: Image
var texture: ImageTexture

func _ready():
	set_canvas()
	$AnimationPlayer.play('default')
	for screen in scratch_screen.get_children():
		screen.set_label_text(get_unique_randomize())

func _input(event):
	if event is InputEventMouseButton:
		mouse_pressed = event.pressed
	if event is InputEventMouseMotion&&mouse_pressed:
		draw_on_canvas(event.position)

func _on_menu_button_pressed():
	$ButtonList.hide()
	$MenuPopUp/Menu.show()

func get_unique_randomize():
	var rand_number = randi_range(1, 300)
	while rand_number in registered_number:
		rand_number = randi_range(1, 300)
	registered_number.append(rand_number)
	return str(rand_number)

func set_canvas():
	image = Image.create(int(get_viewport_rect().size.x), int(get_viewport_rect().size.y), false, Image.FORMAT_RGBA8)
	image.fill(Color('000000'))
	texture = ImageTexture.create_from_image(image)
	$PenCanvas.texture = texture

func draw_on_canvas(pos):
	if $PenCanvas.texture:
		for i in range( - brush_size, brush_size):
			for j in range( - brush_size, brush_size):
				var dist = sqrt(i * i + j * j)
				if dist < brush_size:
					var pixel_pos = Vector2i(pos.x + i, pos.y + j)
					if pixel_pos.x >= 0 and pixel_pos.x < image.get_width() and pixel_pos.y >= 0 and pixel_pos.y < image.get_height():
						image.set_pixelv(pixel_pos, brush_color)
		texture = ImageTexture.create_from_image(image)
		$PenCanvas.texture = texture