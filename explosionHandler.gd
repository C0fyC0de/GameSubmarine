extends Node3D
@onready var sub = $typhoonver4
@onready var torpedoScene = preload("res://torpedoPrefab.tscn").instantiate()
@onready var switchT = false
@onready var timer = $Timer

func _on_torpedo_kolizija(value, torpedo):
	timer.stop()
	print("KOLIZIJAKOLIZIJA")
	var scene = preload("res://podvodna_explozija.tscn").instantiate()
	var flash = scene.get_node("flash")
	var bubbles = scene.get_node("bubling and dissapear")
	var dim = scene.get_node("dim")
	var debris = scene.get_node("debris")
	scene.position = value
	add_child(scene)
	call_deferred("remove_child", torpedo)
	flash.emitting = true
	bubbles.emitting = true
	dim.emitting = true
	debris.emitting = true
	await get_tree().create_timer(4.0).timeout
	remove_child(scene)


func _on_typhoonver_4_spawning_torpedo(scene):
	scene.position = sub.transform.basis * Vector3(0, -10, -50) + sub.position
	scene.rotation = sub.rotation
	scene.rotation.x = sub.rotation.x + PI
	scene.linear_velocity = Vector3.ZERO
	scene.angular_velocity = Vector3.ZERO
	scene.linear_velocity = sub.linear_velocity
	print(scene.rotation)
	call_deferred("add_child", scene)
	timer.start(10.0)
	await timer.timeout
	if switchT == true:
		_on_torpedo_kolizija(scene.position, scene)
	pass # Replace with function body.

func _process(delta):
	var torpedo = get_node_or_null("torpedo")
	switchT = false
	if torpedo != null:
		print("Rotation", torpedo.rotation)
		print("Position", torpedo.position)
		torpedo.connect("kolizija", _on_torpedo_kolizija)
		if(torpedo.position.y >= 3):
			_on_torpedo_kolizija(torpedo.position, torpedo)
		switchT = true
	pass

func _explodiraj(pozicija, tjelozaexplodirat):
	print("KOLIZIJAKOLIZIJA")
	var scene = preload("res://podvodna_explozija.tscn").instantiate()
	var flash = scene.get_node("flash")
	var bubbles = scene.get_node("bubling and dissapear")
	var dim = scene.get_node("dim")
	var debris = scene.get_node("debris")
	scene.position = pozicija
	add_child(scene)
	call_deferred("remove_child", tjelozaexplodirat)
	flash.emitting = true
	bubbles.emitting = true
	dim.emitting = true
	debris.emitting = true
	await get_tree().create_timer(4.0).timeout
	remove_child(scene)
