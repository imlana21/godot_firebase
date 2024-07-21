extends Control

var rotation_speed: float = 360.0
var is_spinning: bool = false
var target_angle: float = 0.0  # Sudut target untuk berhenti
var stop_angle_threshold = 3.0  # Ambang batas untuk berhenti di target
var segment_count = 12  # Jumlah segmen dalam roda
var one_round: float = 360.0
var wheel_rotation: int = 0
var is_popup: bool = false

func _on_spin_btn_pressed():
	reset()
	is_spinning = true
	rotation_speed = 300.0  # Kecepatan awal berputar
	target_angle = get_random_gacha_angle()
	print("Target angle: ", target_angle)

func _on_close_btn_pressed():
	hide()
	var MenuBtn = get_parent().get_parent().find_children('ButtonList')[0]
	MenuBtn.show()	

func _process(delta):
	if is_spinning:
		spin_wheel(delta)
		if abs($SpriteList/Content.rotation_degrees - target_angle) < stop_angle_threshold:
			is_spinning = false
			print("Gacha result: ", get_gacha_result())
		$SpinBtn.disabled = true
	else:
		$SpinBtn.disabled = false

func spin_wheel(delta):
	$SpriteList/Content.rotation_degrees += rotation_speed * delta
		
	if rotation_speed > 0:
		rotation_speed -= 30 * delta
	else:
		is_spinning = false

func get_random_gacha_angle():
	var random_value = randi() % segment_count
	return random_value * (one_round * 2 / segment_count)

func get_gacha_result():
	var index = int(wrapf($SpriteList/Content.rotation_degrees, 0, one_round) / (one_round / segment_count))
	return index

func reset():
	rotation_speed = 300.0
	target_angle = 0.0  # Sudut target untuk berhenti
	stop_angle_threshold = 3.0 
	wheel_rotation = 0

func show_popup() -> void:
	show()
	is_popup = true