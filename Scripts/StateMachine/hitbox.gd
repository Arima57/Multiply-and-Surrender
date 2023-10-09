extends Area2D
@onready var host = get_parent().get_parent()



func _on_body_entered(body):
	stateMachine.attack(body, host)
	host.adversary = body



func _on_body_exited(body):
	host.adversary = null
