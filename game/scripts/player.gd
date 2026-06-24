extends StaticBody2D

var speed = 200;
var height : int;
var viewport_height : int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	viewport_height = get_viewport_rect().size.y;
	height = $"ColorRect".get_size().y;


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_pressed("paddle_up"):
		position.y -= speed * delta;
	elif Input.is_action_pressed("paddle_down"):
		position.y += speed * delta;
	
	position.y = clamp(position.y, height / 2, viewport_height - (height / 2))

func reset () -> void:
	position.y = get_viewport_rect().size.y / 2
