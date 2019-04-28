extends Area2D

func _on_Area2D_body_entered(body):
	var owner = get_owner()
	if body.is_in_group("players") and owner.is_collectable():
		owner.collectBy(body)
