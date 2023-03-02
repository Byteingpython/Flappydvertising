extends RigidBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	
	randomize()
	var count = int(rand_range(-2.5, 2.5)*2)
	while count > -2 and count < 2:
		count = int(rand_range(-2.5, 2.5)*2)
	$RigidBody2D.setMultiplicator(count)
	count = int(rand_range(-2.5, 2.5)*2)
	while count > -2 and count < 2:
		count = int(rand_range(-2.5, 2.5)*2)
	$RigidBody2D2.setMultiplicator(count)
	$RigidBody2D.setTor($RigidBody2D2)
	$RigidBody2D2.setTor($RigidBody2D)
func _physics_process(delta):
	position += transform.x * -400 * delta 
	
func building():
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Area2D_area_entered(area):
	print("collide")

