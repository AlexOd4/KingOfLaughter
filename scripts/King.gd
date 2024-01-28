extends Sprite2D



var pictures_offered = 0
@onready var player = get_node("../player")
var pictures_wanted = 3;
var offered_picture = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if player.position.x > 200  and Global.total_pictures > 3:
		print("BYE BYE :D")
		get_tree().change_scene_to_file("res://scenes/credits.tscn")
