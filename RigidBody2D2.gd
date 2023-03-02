extends RigidBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var multiplicator
var tor
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func setMultiplicator(multiplicatora):
	multiplicator=multiplicatora
	if(multiplicator>=0):
		$Label3.text=str("*"+str(multiplicatora))
		$AnimatedSprite.frame=1
	else:
		$AnimatedSprite.frame=0
		$Label3.text=str("÷"+str(multiplicatora*-1))
	collision_layer=2
func getMultiplicator():
	return multiplicator
func disable():
	$CollisionShape2D.disabled=true
	tor.get_node("CollisionShape2D").disabled=true
func setTor(toor):
	tor=toor

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
