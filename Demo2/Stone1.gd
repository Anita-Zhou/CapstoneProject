extends StaticBody2D

func create_stone_effect():
	pass
	var StoneEffect = load("res://Effects/GrassEffect.tscn")
	var stoneEffect = StoneEffect.instance()
	var world = get_tree().current_scene
	world.add_child(stoneEffect)
	stoneEffect.global_position = global_position

func _on_Hurtbox_area_entered(area):
	create_stone_effect()
	queue_free()
