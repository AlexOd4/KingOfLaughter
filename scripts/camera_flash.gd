extends CanvasLayer

func _process(delta):
	var Global = get_node("/root/Global")
	if Global.picture_taken == false:
		if Input.is_action_just_pressed("ui_accept"):
			$AnimationPlayer.play("camera_flash")
			Global.picture_taken = true;
