extends Area2D



func _on_body_entered(body):
	if "type" in body:
		if body.type == "hero":
			body.hero_health = 0
		elif body.type == "low_grade" or body.type == "high_grade":
			body.HP = 0
