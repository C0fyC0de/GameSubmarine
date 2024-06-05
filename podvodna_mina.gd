extends Node3D
@onready var podvodna_mina = $"."
signal explo(poz, tj)


func _on_body_entered(body):
	emit_signal("explo", podvodna_mina.position, podvodna_mina)
