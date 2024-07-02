extends Control

@onready var scratch_screen := $ScratchScreen

var mouse_pressed: bool = false
var curr_line: Line2D
var registered_number: Array = []
var brush_size = 10
var brush_color = Color(1, 1, 1, 0)
var image: Image
var texture: ImageTexture


func _on_button_pressed():	
	Firebase.Auth.logout()
	get_tree().change_scene_to_file("res://project/auth.tscn")

func _input(event):
	if event is InputEventMouseButton:
		mouse_pressed = event.pressed
		# if mouse_pressed:
		# 	curr_line = Line2D.new()
		# 	curr_line.default_color = Color.WHITE
		# 	$Line.add_child(curr_line)
	if event is InputEventMouseMotion && mouse_pressed:
		# curr_line.add_point(event.position)
		draw_on_texture(event.position)
	
func draw_on_texture(pos):
	if $PenCanvas.texture:
		# var image = $PenCanvas.texture.get_data()
		# image.lock()
		for i in range(-brush_size, brush_size):
			for j in range(-brush_size, brush_size):
				var dist = sqrt(i * i + j * j)
				if dist < brush_size:
					var pixel_pos = Vector2i(pos.x + i, pos.y + j)
					if pixel_pos.x >= 0 and pixel_pos.x < image.get_width() and pixel_pos.y >= 0 and pixel_pos.y < image.get_height():
						image.set_pixelv(pixel_pos, brush_color)
		# image.unlock()
		texture = ImageTexture.create_from_image(image)
		$PenCanvas.texture = texture
		# $PenCanvas.texture.create_from_image(image)

func _ready():
	image = Image.create(int(get_viewport_rect().size.x), int(get_viewport_rect().size.y), false, Image.FORMAT_RGBA8)
	image.fill(Color('000000'))
	texture = ImageTexture.create_from_image(image)
	$PenCanvas.texture = texture
	$AnimationPlayer.play('default')
	for screen in scratch_screen.get_children():
		screen.set_label_text(get_unique_randomize())

func get_unique_randomize():
	var rand_number = randi_range(1, 300)
	while rand_number in registered_number:
		rand_number = randi_range(1, 300)
	registered_number.append(rand_number)
	return str(rand_number)
