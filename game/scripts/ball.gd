extends CharacterBody2D

const INIT_SPEED  : int = 205;
const PLAY_SPEED  : int = 200;
var speed         : int
var dir           : Vector2
var viewport_size : Vector2
var last_collision: Object

func _ready() -> void:
	viewport_size = get_viewport_rect().size;
	

func reset () -> void:
	position.x = viewport_size.x / 2;
	position.y = viewport_size.y / 2;
	
	speed = 0
	
func serve (to: int) -> void:	
	dir.x = to;
	dir.y = randf_range(-1, 1);
	
	speed = INIT_SPEED;

func _physics_process(delta: float) -> void:
	if speed > 0:
		var collision = move_and_collide(dir.normalized() * speed * delta)
		
		if collision:
			var collider = collision.get_collider()
			
			if collider == $"../UserPaddle" or collider == $"../CPUPaddle":
				dir = new_direction(collider);
			else:
				dir = dir.bounce(collision.get_normal());
			
func new_direction (collider: StaticBody2D) -> Vector2:
	var new_dir = Vector2(0,0);
	var dist = position.y - collider.position.y
	
	if collider == $"../CPUPaddle":
		new_dir.x = -1;
	else:
		new_dir.x = 1;
		
	new_dir.y = (dist / (collider.height / 2))
		
	return new_dir.normalized();
	
