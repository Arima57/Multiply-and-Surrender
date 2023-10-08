extends Node2D

func _ready():
	stateMachine.spawn($".", Vector2(100, -100))
