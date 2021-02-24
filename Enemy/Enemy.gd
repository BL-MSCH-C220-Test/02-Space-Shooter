extends KinematicBody2D

var health = 100
var velocity = Vector2.ZERO
var speed_limit = 10
var drag = 0.05
	
func _physics_process(_delta):
	position += velocity
	if velocity.length() > speed_limit:
		velocity = velocity.normalized() * speed_limit
	if velocity.length() > drag:
		velocity = velocity.normalized() * (velocity.length() - drag)
	position.x = wrapf(position.x,0,Global.width)
	position.y = wrapf(position.y,0,Global.height)
	
	$Health.value = health
	$Health.set_rotation(-rotation)
	if health >= 100:
		$Health.hide()
	else:
		$Health.show()
	if health > 70:
		$Health.tint_progress = Color8(116,184,22)
	elif health > 40:
		$Health.tint_progress = Color8(240,140,0)
	else:
		$Health.tint_progress = Color8(224,49,49)


func damage(d):
	health -= d
	if health <= 0:
		queue_free()
