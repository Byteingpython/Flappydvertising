 extends Area2D

signal despawn(entity)
signal score()
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
signal multiply(multiplicator)
signal divide(multiplicator)

var running=true

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


func _process(delta):
	pass
	
func _physics_process(delta):
	if(Input.is_action_pressed("up")):
		position += transform.y * -200 *delta
		$CollisionShape2D.rotation_degrees =-30
	else:
		position += transform.y * 200 *delta
		$CollisionShape2D.rotation_degrees = 30
	

	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_VisibilityNotifier2D_screen_exited():
	
	emit_signal("despawn", self)
	





func _on_RigidBody2D_area_entered(area):
	
	_on_VisibilityNotifier2D_screen_exited()


func _on_RigidBody2D_body_entered(body):
	if(body.has_method("getMultiplicator")):
		print(body.getMultiplicator())
		if(body.getMultiplicator()>=0):
			emit_signal("multiply", body.getMultiplicator())
		else:
			emit_signal("divide", body.getMultiplicator()*-1)
		body.disable()
		return
		
	_on_VisibilityNotifier2D_screen_exited()


func _on_Timer_timeout():
	if(running):
		emit_signal("score")
		
