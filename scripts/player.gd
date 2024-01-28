extends CharacterBody2D


const SPEED = 110.0
const ACCELERATION = 450.0
const FRICTION = 900.0
const JUMP_VELOCITY = -350.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var pic_start = 5
var pic_end = 4
var rot_sprite = false
var photo = false

@onready var tutorial_text = get_node("../Label")
@onready var endgame_text = get_node("../Label2")
@onready var anim_pic2 = get_node("../Pic2/Sprite2D/AnimationPlayer")
@onready var anim_pic1 = get_node("../Pic1/Sprite2D/AnimationPlayer")
@onready var anim_pic3 = get_node("../Pic3/Sprite2D/AnimationPlayer")
@onready var king_pointer = get_node("Camera2D/pointer")
@onready var king_animation = get_node("Camera2D/pointer/AnimationPlayer")

func _physics_process(delta): 
	apply_gravity(delta)
	handle_jump()
	var input_axis = Input.get_axis("ui_left", "ui_right")
	handle_acceleration(input_axis, delta)
	apply_friction(input_axis, delta)
	move_and_slide()
	$Sprite2D.flip_h = rot_sprite
	
	var time_left = $Timer.get_time_left()
	if time_left > pic_end and time_left < pic_start:
		$PhotoPrompt.visible = true
		if Input.is_action_just_pressed("ui_accept"):
			Global.good_pictures += 1;
			print("LET'S GOOOOOOOOOOO Good pics = " + str(Global.good_pictures))
	else:
		$PhotoPrompt.visible = false
	if Input.is_action_just_pressed("ui_accept"):
		if time_left != 0 and time_left < pic_end or time_left > pic_start:
			Global.bad_pictures += 1;
			print("This sucks man...Bad pics = " + str(Global.bad_pictures))
	
	if Input.is_action_just_pressed("ui_accept"):
		$AnimationPlayer.play("takePhoto")
		$TimerPhoto.start()
		$AudioStreamPlayer.play()
		photo = true
		
	if position.x < -960 :
		hide_tut_text()
		
	if Global.total_pictures > 3:
		show_endgame_text()
		show_king_pointer()
		
func apply_gravity(delta):
	if not is_on_floor():
		velocity.y += gravity * delta

func handle_jump():
		if is_on_floor():
			if Input.is_action_just_pressed("ui_up"):
				velocity.y = JUMP_VELOCITY
		else: 
			if Input.is_action_just_released("ui_up") and velocity.y < JUMP_VELOCITY / 2:
				velocity.y = JUMP_VELOCITY / 2
			$AnimationPlayer.play("jump")

	
func handle_acceleration(input_axis, delta):
	if input_axis != 0:
		velocity.x = move_toward(velocity.x, SPEED * input_axis, ACCELERATION * delta)
		if is_on_floor():
			$AnimationPlayer.play("Running")
		if velocity.x > 0:
			rot_sprite = false
		elif velocity.x < 0:
			rot_sprite = true
	else:
		if not photo:
			$AnimationPlayer.play("Idle")
		
func apply_friction(input_axis, delta):
	if input_axis == 0:
		velocity.x = move_toward(velocity.x, 0, FRICTION * delta)
		
func _on_pic_1_body_entered(body): #en realidad es el PIC2!!!!!
	$Timer.set_wait_time(7)
	$Timer.start()
	anim_pic2.play("Farting")
	
func _on_pic_2_body_entered(body): #en realidad es el PIC1!!!!!
	$Timer.set_wait_time(7)
	$Timer.start()
	anim_pic1.play("football")
	
func _on_pic_3_body_entered(body): #en realidad es el PIC3!!!!!
	$Timer.set_wait_time(7)
	$Timer.start()
	anim_pic3.play("chair")

	
func _on_timer_timeout():
	$Timer.stop()
	print("Pic opportunity missed...")
	
func hide_tut_text():
	tutorial_text.visible = false;

func show_endgame_text():
	endgame_text.visible = true;

func show_king_pointer():
	king_pointer.visible = true;
	king_animation.play("pointer")

func _on_timer_photo_timeout():
	photo = false
