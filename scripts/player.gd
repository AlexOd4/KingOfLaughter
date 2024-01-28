extends CharacterBody2D


const SPEED = 110.0
const ACCELERATION = 450.0
const FRICTION = 900.0
const JUMP_VELOCITY = -350.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var pic_start = 5
var pic_end = 3.5

func _physics_process(delta): 
	apply_gravity(delta)
	handle_jump()
	var input_axis = Input.get_axis("ui_left", "ui_right")
	handle_acceleration(input_axis, delta)
	apply_friction(input_axis, delta)
	move_and_slide()
	
	var time_left = $Timer.get_time_left()
	if Input.is_action_just_pressed("ui_accept"):
		if time_left > pic_end and time_left < pic_start:
			Global.good_pictures += 1;
			print("LET'S GOOOOOOOOOOO Good pics = " + str(Global.good_pictures))
		if time_left != 0 and time_left < pic_end or time_left > pic_start:
			Global.bad_pictures += 1;
			print("This sucks man...Bad pics = " + str(Global.bad_pictures))
		
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
				
func handle_acceleration(input_axis, delta):
	if input_axis != 0:
		velocity.x = move_toward(velocity.x, SPEED * input_axis, ACCELERATION * delta)
		
func apply_friction(input_axis, delta):
	if input_axis == 0:
		velocity.x = move_toward(velocity.x, 0, FRICTION * delta)
		
func _on_pic_1_body_entered(body):
	$Timer.set_wait_time(7)
	$Timer.start()

func _on_pic_2_body_entered(body):
	$Timer.set_wait_time(7)
	$Timer.start()

func _on_pic_3_body_entered(body):
	$Timer.set_wait_time(7)
	$Timer.start()
	
func _on_timer_timeout():
	$Timer.stop()
	print("Pic opportunity missed...")
