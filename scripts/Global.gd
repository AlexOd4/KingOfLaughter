extends Node
var good_pictures = 0;
var bad_pictures = 0;
var total_pictures = 0;

func _process(delta):
	total_pictures = good_pictures + bad_pictures;
