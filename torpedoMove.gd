extends Node3D
signal kolizija(value)
@onready var torpedo = $"."
@onready var animation_player = $AnimationPlayer
@onready var speedOfPropeler = 10
@onready var flag = true
# Called when the node enters the scene tree for the first time.
func _ready():
	animation_player.play("propellerTorpedoAnim")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
	
func _physics_process(delta):
	torpedo.apply_central_force(torpedo.transform.basis.z * speedOfPropeler)


func _on_body_entered(body):
	if flag==true:
		emit_signal("kolizija", torpedo.position)
		flag = false
	pass # Replace with function body.

