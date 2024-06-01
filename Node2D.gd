extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export(PackedScene) var building_scene
export(PackedScene) var plane_scene

var planes = []
var score = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	
	
func start():
	var plane = plane_scene.instance()
	add_child(plane)
	planes.append(plane)
	plane.position=Vector2(121.923, 290.541)
	plane.connect("despawn", self, "_on_despawn")
	plane.connect("score", self, "_on_score")
	plane.connect("multiply", self, "multiply")
	plane.connect("divide", self, "divide")
	$AudioStreamPlayer.seek(36.1)
	$Menu.hide()
	$Timer.start()
	
func stop():
	$Timer.stop()
	$Timer2.start()
	$Label.text=str(score)
	
	
	

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

func multiply(Multiplicator):
	var plane
	for i in range(clamp(planes.size()*(Multiplicator-1), 0, 20-planes.size())):
		plane = plane_scene.instance()
		add_child(plane)
		planes.append(plane)
		plane.position=planes[0].position+Vector2(rand_range(-50, 50), rand_range(-50, 50))
		while plane.get_overlapping_bodies().size()>0:
			plane.position=planes[0].position+Vector2(rand_range(-50, 50), rand_range(-50, 50))
		plane.connect("despawn", self, "_on_despawn")
		plane.connect("score", self, "_on_score")
		plane.connect("multiply", self, "multiply")
		plane.connect("divide", self, "divide")
	$AudioStreamPlayer.pitch_scale=1+(planes.size()-1)*0.003
	
func divide(Dividend):
	print("divide")
	for i in range(int(round(planes.size()-(planes.size()/Dividend)))):
		planes[i].queue_free()
	print(planes.size())
	$AudioStreamPlayer.pitch_scale=1+(planes.size()-1)*0.003
	
	
func _on_Timer_timeout():
	var building = building_scene.instance()
	var offset = rand_range(-50, 50)
	add_child(building)
	building.position = Vector2(1068, 520+offset)
	building = building_scene.instance()
	add_child(building)
	building.position = Vector2(1068, offset)
	
	
func _on_despawn(entity):
	planes.erase(entity) 
	entity.queue_free()
	if(planes.size()==0):
		stop()
	$AudioStreamPlayer.pitch_scale=1+(planes.size()-1)*0.003	

func _on_score():
	score +=1
	
		


func _on_Timer2_timeout():
	$Label.show()


func _on_Button_button_down():
	$AudioStreamPlayer/Tween.interpolate_property($AudioStreamPlayer, "volume_db", -20, -80, 1, 1, Tween.EASE_IN, 0)
	$AudioStreamPlayer/Tween.start()
	$Timer3.start()
	$Label/Button.hide()


func _on_Timer3_timeout():
	get_tree().reload_current_scene()
func _notification(what):
	if what == MainLoop.NOTIFICATION_WM_FOCUS_OUT:
		get_tree().paused=true
	elif what == MainLoop.NOTIFICATION_WM_FOCUS_IN :
		get_tree().paused=false


func _on_TextureButton_button_down():
	get_tree().quit()
