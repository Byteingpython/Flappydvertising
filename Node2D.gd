extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export(PackedScene) var building_scene
export(PackedScene) var plane_scene

var planes = []

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	var plane = plane_scene.instance()
	add_child(plane)
	planes.append(plane)
	plane.position=Vector2(121.923, 290.541)

#func _process(delta):
#	if(Input.is_action_pressed("up")):
#		$Plane.position += transform.y * -300 *delta
#		$Plane.rotation_degrees =-30
#	else:
#		$Plane.position += transform.y * 300 *delta
#		$Plane.rotation_degrees = 30
#
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Timer_timeout():
	print("spawn")
	var building = building_scene.instance()
	var offset = rand_range(-50, 50)
	add_child(building)
	building.position = Vector2(1068, 520+offset)
	building = building_scene.instance()
	add_child(building)
	building.position = Vector2(1068, 50+offset)
