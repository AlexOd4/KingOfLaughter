extends Label

func _process(delta):
	if Global.good_pictures > Global.bad_pictures :
		self.text = "The king finds your pictures funny!\nTotal pictures: " + str(Global.total_pictures)
	else:
		self.text = "The king hated your pictures...\nGOOD: " + str(Global.good_pictures) + " / BAD: " + str(Global.bad_pictures)
