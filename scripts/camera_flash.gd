extends CanvasLayer

var Reset_done = false

func _process(delta):
	var Global = get_node("/root/Global")
	if Input.is_action_just_pressed("ui_accept"):
		$AnimationPlayer.play("camera_flash")
		print("Picture snapped")
