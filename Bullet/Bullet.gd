extends Area2D

var velocity = Vector2(0, -15)
var power = 10

var Explosion = load("res://Bullet/Explosion.tscn")
onready var Explosions = get_node_or_null("/root/Game/Explosions")


func _physics_process(_delta):
	position += velocity
	if position.x < 0 or position.x > Global.width or position.y < 0 or position.y > Global.height:
		queue_free()
	


func _on_Bullet_body_entered(body):
	if body.has_method("damage"):
		body.damage(power)
	if Explosions != null:
		var explosion = Explosion.instance()
		explosion.position = position
		Explosions.add_child(explosion)
		explosion.playing = true
	queue_free()
