extends KinematicBody2D

var velocity = Vector2.ZERO
var speed_limit = 10
var rot = 5
var speed = 0.2
var width = 7148
var height = 2930
onready var VP = get_viewport_rect().size

onready var Enemy = get_node("/root/Game/Enemy")

func _physics_process(_delta):
	position += velocity
	velocity += get_input()*speed
	if velocity.length() > speed_limit:
		velocity = velocity.normalized() * speed_limit
	position.x = wrapf(position.x,0,width)
	position.y = wrapf(position.y,0,height)
	
	var distance = position - Enemy.position
	var ratio_x = abs(distance.x / VP.x)
	var ratio_y = abs(distance.y / VP.y)
	var zFactor = ratio_x
	if ratio_y > ratio_x:
		zFactor = ratio_y
	zFactor = clamp(zFactor*2,0.5,3)
	$Camera2D.zoom = Vector2(zFactor,zFactor)
			
		
	


func get_input():
	var input_vector = Vector2.ZERO
	$Thrust.hide()
	if Input.is_action_pressed("up"):
		$Thrust.show()
		input_vector.y -= 1
	if Input.is_action_pressed("left"):
		rotation_degrees -= rot
	if Input.is_action_pressed("right"):
		rotation_degrees += rot
	return input_vector.rotated(rotation)


func _on_Area2D_body_entered(body):
	$Area2D/Shield.show()


func _on_Area2D_body_exited(body):
	$Area2D/Shield.hide()
