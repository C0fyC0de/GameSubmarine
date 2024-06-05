extends Node3D
@onready var floor = $"."
@onready var sub = $"../typhoonver4"
@onready var ypos = floor.position.y




func _process(delta):
	floor.position.x = sub.position.x
	floor.position.z = sub.position.z
	floor.position.y = ypos
	pass
