extends Node

@onready var anim_tree = $AnimationTree
@onready var sub = $"."
@onready var node_3d = $Node3D
@onready var StartOffset = node_3d.transform.origin - sub.transform.origin
@onready var add_value = 1
@onready var torqueforce = 70000
@onready var speedpropeler = 7000
@onready var ballastforce = 5000
@onready var torqueProtuSila = 150000
@onready var animation_player = $AnimationPlayer
@onready var switch = 0
@onready var torpedoScene = preload("res://torpedoPrefab.tscn").instantiate()
signal spawningTorpedo(scene)

func is_scene_in_tree():
	var root = get_tree().get_root()
	for node in root.get_children():
		if node.filename == torpedoScene.resource_path:
			return true
		else:
			return false



func balans():
	if(sub.rotation.z > 0.01):
		sub.apply_torque(sub.transform.basis * Vector3(0, 0, -sub.rotation.z*10000))
	if(sub.rotation.z < -0.01):
		sub.apply_torque(sub.transform.basis * Vector3(0, 0, -sub.rotation.z*10000))
	if(sub.rotation.x > 0.01):
		sub.apply_torque(sub.transform.basis * Vector3(-sub.rotation.x*torqueProtuSila, 0, 0))
	if(sub.rotation.x < -0.01):
		sub.apply_torque(sub.transform.basis * Vector3(-sub.rotation.x*torqueProtuSila, 0, 0))
	if(sub.position.y >= 3):
		sub.apply_central_force(Vector3(0, -ballastforce*3, 0))
	
	#print(sub.rotation.x)
	#print(sub.linear_velocity)
	#print(sub.angular_velocity)
	#lokalna_brzina()
	#print(anim_tree.get("parameters/Animation/time"))

func lokalna_brzina():
	#lokalna brzina
	var b = sub.transform.basis
	var v_len = sub.linear_velocity.length()
	var v_nor = sub.linear_velocity.normalized()
	var vel : Vector3
	vel.x = b.x.dot(v_nor) * v_len
	vel.y = b.y.dot(v_nor) * v_len
	vel.z = b.z.dot(v_nor) * v_len
	print(vel)

func update_tree():
	anim_tree["parameters/PropellerCtrl/add_amount"] = add_value

func _ready():
	update_tree()
	var anim_tree = get_node("/root/Node3D/typhoonver4/AnimationTree")
	for property in anim_tree.get_property_list():
		print(property.name)


	
func _process(delta):
	node_3d.transform.origin = sub.transform.origin + StartOffset
	update_tree()


func _physics_process(delta):
	if(sub.angular_velocity.y < 0.2):
		if Input.is_key_pressed(KEY_A):
			sub.apply_torque(sub.transform.basis * Vector3(0, torqueforce, 0))
	if(sub.angular_velocity.y > -0.2):
		if Input.is_key_pressed(KEY_D):
			sub.apply_torque(sub.transform.basis * Vector3(0, -torqueforce, 0))
	if(sub.angular_velocity.x < 0.2 and sub.rotation.x <= 0.3 and sub.position.y < -2):
		if Input.is_key_pressed(KEY_SHIFT):
			sub.apply_torque(sub.transform.basis * Vector3(torqueforce, 0, 0))
	if(sub.angular_velocity.x > -0.2 and sub.rotation.x >= -0.3 and sub.position.y < -4):
		if Input.is_key_pressed(KEY_CTRL):
			sub.apply_torque(sub.transform.basis * Vector3(-torqueforce, 0, 0))
			
			
			
	if(sub.linear_velocity.z > -100):
		if Input.is_key_pressed(KEY_W):
			sub.apply_central_force(sub.transform.basis.z * -speedpropeler)
			
	if(sub.linear_velocity.z < 100):
		if Input.is_key_pressed(KEY_S):
			sub.apply_central_force(sub.transform.basis.z * speedpropeler)
	
	if(sub.linear_velocity.y < 100 and sub.position.y < 3):
		if Input.is_key_pressed(KEY_SPACE):
			sub.apply_central_force(Vector3(0, ballastforce, 0))
		
	if(sub.linear_velocity.y < 100):
		if Input.is_key_pressed(KEY_C):
			sub.apply_central_force(Vector3(0, -ballastforce, 0))
	
	if Input.is_key_pressed(KEY_X) and !get_node_or_null("../torpedo"):
		emit_signal("spawningTorpedo", torpedoScene)
	balans()
	
