extends Control

func _ready():
	Firebase.Auth.login_succeeded.connect(on_login_succeeded)
	Firebase.Auth.login_failed.connect(on_login_failed)
	Firebase.Auth.signup_succeeded.connect(on_signup_succeeded)

	if Firebase.Auth.check_auth_file():
		show_label("Welcome")

func _on_login_button_pressed():
	var email = $Form/Email/Input.text
	var passwd = $Form/Password/Input.text
	if $Form/RuleValidation/CheckBox.button_pressed:
		Firebase.Auth.login_with_email_and_password(email, passwd)
		show_label("Logging In")
	else:
		show_label("Check the rule and agreement")
	
func _on_register_button_pressed():
	var email = $Form/Email/Input.text
	var passwd = $Form/Password/Input.text
	if $Form/RuleValidation/CheckBox.button_pressed:
		Firebase.Auth.signup_with_email_and_password(email, passwd)
		show_label("Singing up")
	else:
		show_label("Check the rule and agreement")

func on_login_succeeded(auth):
	if $Form/RuleValidation/CheckBox.button_pressed:
		show_label("Login Success")
		Firebase.Auth.save_auth(auth)
		var firestore_collection : FirestoreCollection = Firebase.Firestore.collection('points')
		var firestore_document = await firestore_collection.get_doc(auth.email)
		Game.set_player_data(firestore_document)
		print(Game.player_data)
		print("Data loaded for user " + auth.email)
		get_tree().change_scene_to_file("res://project/main.tscn")
	
func on_signup_succeeded(auth):
	on_login_succeeded(auth)

func on_login_failed(err_code, msg):
	if $Form/RuleValidation/CheckBox.button_pressed:
		print_debug(err_code)
		print_debug(msg)
		show_label("Login failed. Error: %s" % msg)
	
func on_signup_failed(err_code, msg):
	if $Form/RuleValidation/CheckBox.button_pressed:
		print_debug(err_code)
		print_debug(msg)
		show_label("Register failed. Error: %s" % msg)

func show_label(text):
	$Form/Label.text = text
	$Form/Label.show()
	await get_tree().create_timer(5).timeout
	$Form/Label.hide()
	                   
# Eamail = admin@stormy.project
# Password = admin123456

