extends KinematicBody2D

var velocity = Vector2.ZERO
var speed = 0.2
var speed_limit = 10
var rot = 5
var width = 7146
var height = 2930

onready var VP = get_viewport_rect().size

onready var Enemy = get_node_or_null("/root/Game/Enemy")
onready var Camera = get_node_or_null("/root/Game/Camera")

var shield_deplete = false
var shield_strength = 100
var damage = 1
var regenerate = 0.1

var shield_textures = [
	load("res://Assets/shield.png")
	,load("res://Assets/shield2.png")
	,load("res://Assets/shield3.png")
]

func _physics_process(_delta):
	position += velocity
	velocity += get_input()*speed
	if velocity.length() > speed_limit:
		velocity = velocity.normalized() * speed_limit
	position.x = wrapf(position.x,0,width)
	position.y = wrapf(position.y,0,height)
	if Enemy != null:
		var distance = position - Enemy.position
		var midway = (Enemy.global_position - global_position)/2 + global_position
		var ratio = (distance.length() / VP.length()) * 2
		ratio = clamp(ratio, 1, 4)
		Camera.global_position = midway
		Camera.zoom = Vector2(ratio,ratio)
	else:
		Enemy = get_node_or_null("/root/Game/Enemy")
	if shield_deplete:
		shield_strength -= damage
		if shield_strength >= 75:
			$Shield/Sprite.texture = shield_textures[0]
		elif shield_strength >= 40:
			$Shield/Sprite.texture = shield_textures[1]
		elif shield_strength >= 0:
			$Shield/Sprite.texture = shield_textures[2]
		else:
			$Shield/Sprite.hide()
	else:
		shield_strength += regenerate
	shield_strength = clamp(shield_strength,0,100)



func get_input():
	var input_vector = Vector2.ZERO
	$Thrust.hide()
	if Input.is_action_pressed("up"):
		input_vector.y -= 1
		$Thrust.show()
	if Input.is_action_pressed("left"):
		rotation_degrees -= rot
	if Input.is_action_pressed("right"):
		rotation_degrees += rot
	return input_vector.rotated(rotation)


func _on_Shield_body_entered(_body):
	$Shield/Sprite.show()
	shield_deplete = true


func _on_Shield_body_exited(_body):
	$Shield/Sprite.hide()
	shield_deplete = false
