extends CharacterBody2D

var hurt:int
var speed:int
var dir:Vector2 = Vector2.ZERO

func _process(delta):
	velocity = speed * delta * dir
	move_and_slide()

func _on_area_2d_body_shape_entered(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	if body.is_in_group("enemy"):
		body.hp -= hurt
		self.queue_free()
	if body is TileMap:
		var coords = body.get_coords_for_body_rid(body_rid)
		var tile_data = body.get_cell_tile_data(5, coords)
		if tile_data:
			var isWall = tile_data.get_custom_data("isWall")
			if isWall:
				self.queue_free()
