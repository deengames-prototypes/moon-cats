extends Node2D

func _ready():
	$CollisionShape2D.shape.extents = Vector2(Constants.SECTION_WIDTH / 2, Constants.SECTION_HEIGHT / 2)
	$CollisionShape2D.position = $CollisionShape2D.shape.extents
	$ColorRect.margin_right = Constants.SECTION_WIDTH
	$ColorRect.margin_bottom = Constants.SECTION_HEIGHT
	
	# TODO: add a random fan or something animated
