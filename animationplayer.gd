extends Node

@onready var anim_tree = $AnimationTree
@onready var sub = $"."
@onready var node_3d = $Node3D
@onready var StartOffset = node_3d.transform.origin - sub.transform.origin
@onready var add_value = 1
@onready var torqueforce = 70000
@onready var speedpropeler = 10000

func balans():
	#print(sub.rotation)
	print(sub.linear_velocity)
	#print(sub.angular_velocity)

func update_tree():
	anim_tree["parameters/PropellerCtrl/add_amount"] = add_value
	anim_tree.active = true

#func _ready():
	#update_tree()
	
func _process(delta):
	node_3d.transform.origin = sub.transform.origin + StartOffset


func _physics_process(delta):
	if(sub.angular_velocity.y < 0.2):
		if Input.is_key_pressed(KEY_A):
			sub.apply_torque(sub.transform.basis * Vector3(0, torqueforce, 0))
	if(sub.angular_velocity.y > -0.2):
		if Input.is_key_pressed(KEY_D):
			sub.apply_torque(sub.transform.basis * Vector3(0, -torqueforce, 0))
			
			
			
	if(sub.linear_velocity.z > -10):
		if Input.is_key_pressed(KEY_W):
			sub.apply_central_force(sub.transform.basis * Vector3(0, 0, -speedpropeler))
	else:
		sub.linear_velocity.z = -10
	if(sub.linear_velocity.z < 5):
		if Input.is_key_pressed(KEY_S):
			sub.apply_central_force(sub.transform.basis * Vector3(0, 0, speedpropeler))
	else:
		sub.linear_velocity.z = 5
		
		
#UGASI NAPRIJED NAZAD KAD X VELOCITY IZNAD 20
		
	balans()
