extends Node

var score = 0

func _process(delta):
	if Input.is_action_pressed("quit"):	
		get_tree().quit()
