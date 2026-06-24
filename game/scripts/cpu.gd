extends StaticBody2D

var speed         : int;
var height        : int;
var viewport_size : Vector2;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	speed = 100;
	height = $ColorRect.get_size().y
	viewport_size = get_viewport_rect().size;


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var ball = $"../Ball";
	var dist = position.y - ball.position.y;
	
	if abs(dist) >= (speed * delta):
		position.y -= speed * delta * (dist / abs(dist));
	else:
		position.y -= dist

	position.y = clamp(position.y, height / 2, viewport_size.y - (height / 2))

func reset () -> void:
	position.y = get_viewport_rect().size.y / 2
