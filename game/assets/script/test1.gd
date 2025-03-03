extends Sprite2D

var number : int = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	print("hello world")
	position = Vector2(-700,0)
	pass # Replace with function body.

"""
hsgdfjhgbdjhgdj
"""
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position.x += 1000 * delta
	if 50 >= 0:
		print("true")
		pass
	pass
