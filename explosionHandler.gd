extends Node3D
@onready var torpedo = $torpedo

func _on_torpedo_kolizija(value):
	print("KOLIZIJAKOLIZIJA")
	var scene = preload("res://podvodna_explozija.tscn").instantiate()
	var flash = scene.get_node("flash")
	var bubbles = scene.get_node("bubling and dissapear")
	var dim = scene.get_node("dim")
	var debris = scene.get_node("debris")
	scene.position = value
	add_child(scene)
	remove_child(torpedo)
	flash.emitting = true
	bubbles.emitting = true
	dim.emitting = true
	debris.emitting = true
	await get_tree().create_timer(4.0).timeout
	remove_child(scene)
