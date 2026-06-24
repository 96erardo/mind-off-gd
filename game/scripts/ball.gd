extends CharacterBody2D

const INIT_SPEED  : int = 205;
const PLAY_SPEED  : int = 200;
var speed         : int
var dir           : Vector2
var viewport_size : Vector2
var last_collision: Object
var time_in_left: float = 0;
var time_in_right: float = 0;

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
	var prevPos = position;
	
	if speed > 0:
		var collision = move_and_collide(dir.normalized() * speed * delta)
		
		if collision:
			var collider = collision.get_collider()
			
			if collider == $"../UserPaddle" or collider == $"../CPUPaddle":
				dir = new_direction(collider);
			else:
				dir = dir.bounce(collision.get_normal());
		
		var viewport = get_viewport_rect();
		
		if position.x > viewport.size.x / 2:
			time_in_left = 0;
			time_in_right += delta;
		else:
			time_in_right = 0;
			time_in_left += delta;
		
		if time_in_left > 4 || time_in_right > 4:
			time_in_left = 0;
			time_in_right = 0;
			get_parent()._on_reset_timer_timeout();
		
func new_direction (collider: StaticBody2D) -> Vector2:
	var new_dir = Vector2(0,0);
	var dist = position.y - collider.position.y
	
	if collider == $"../CPUPaddle":
		new_dir.x = -1;
	else:
		new_dir.x = 1;
		
	new_dir.y = (dist / (collider.height / 2))
		
	return new_dir.normalized();
	
