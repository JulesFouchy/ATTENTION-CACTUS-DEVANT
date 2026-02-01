extends Movable
@onready var sprite_3d: Sprite3D = %Sprite3D
var texture: Texture2D

@export var amplitude: float = 0.2      # hauteur de l’oscillation
@export var speedmoov: float = 2     # vitesse de l’oscillation
var base_y: float

func _ready() -> void:
	sprite_3d.texture = texture
	base_y = 1	
	
func _process(delta: float) -> void:
	global_translate(Vector3(-delta * speed, 0, 0))
	position.y = base_y + sin(Time.get_ticks_msec() * 0.001 * speedmoov) * amplitude;
	if position.x < -10.:
		destroy()
		
	
