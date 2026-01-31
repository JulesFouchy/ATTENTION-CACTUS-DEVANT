extends Movable
@onready var sprite_3d: Sprite3D = %Sprite3D
var texture: Texture2D

func _ready() -> void:
	sprite_3d.texture = texture
