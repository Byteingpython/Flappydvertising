 extends Area2D

signal despawn
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	print("ready")

func _physics_process(delta):
	if(Input.is_action_pressed("up")):
		get_node("Plane")
func _process(delta):

	if(Input.is_action_pressed("up")):
		$Plane.position += transform.y * -300 *delta
		$Plane.rotation_degrees =-30
	else:
		$Plane.position += transform.y * 300 *delta
		$Plane.rotation_degrees = 30
	if(get_overlapping_areas().size()>=1):
		_on_RigidBody2D_area_entered(get_overlapping_areas()[1])
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_VisibilityNotifier2D_screen_exited():
	print("despawn")
	emit_signal("despawn")
	queue_free()





func _on_RigidBody2D_area_entered(area):
	print("colission")
	_on_VisibilityNotifier2D_screen_exited()
