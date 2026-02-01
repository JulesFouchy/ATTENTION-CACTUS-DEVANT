extends IconeDrag

var amplitude: float = 10.0      # hauteur de l’oscillation
var speed: float = 1.6        # vitesse de l’oscillation
var base_y: float   
var randomstart: float
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	base_y = position.y
	randomstart = randf_range(0.,10000.7)



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position.y = base_y + sin((Time.get_ticks_msec()+randomstart) * 0.001 * speed) * amplitude
