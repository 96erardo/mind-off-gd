class_name Character extends StaticBody2D

signal destination_reached

const SPEED: int = 50
var world: TileMapLayer
var gridPos: Vector2i
var units: int = 0;
var dir: Vector2i

@export var sprite_frames: SpriteFrames;
@export var animation: String;
@export var frame: int = 0;
@export var flip_horizontally = false;
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if sprite_frames:
		sprite.sprite_frames = sprite_frames
		sprite.animation = animation;
		sprite.frame = frame;
		sprite.flip_h = flip_horizontally
	
	dir = Vector2i.ZERO
	
	world = get_parent()
	gridPos = world.local_to_map(position)
	position = gridPos * 16;


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if dir != Vector2i.ZERO:
		var destination: Vector2 = (gridPos + (dir * units)) * 16;
		
		if dir == Vector2i.LEFT:
			position.x = clampf(position.x - (SPEED * delta), destination.x, position.x)
		elif dir == Vector2i.RIGHT:
			position.x = clampf(position.x + (SPEED * delta), position.x, destination.x)
		elif dir == Vector2i.UP:
			position.y = clampf(position.y - (SPEED * delta), destination.y, position.y)
		elif dir == Vector2i.DOWN:
			position.y = clampf(position.y + (SPEED * delta), position.y, destination.y)
		
		if position == destination:
			gridPos = gridPos + (dir * units)
			
			dir = Vector2i.ZERO;
			units = 0;
			
			$AnimatedSprite2D.stop()
			
			destination_reached.emit()

func turn (dir: Vector2i) -> void:
	if dir == Vector2i.UP:
		$AnimatedSprite2D.animation = "walk_up"
		$AnimatedSprite2D.flip_v = false
	elif dir == Vector2i.DOWN:
		$AnimatedSprite2D.animation = "walk_down"
		$AnimatedSprite2D.flip_v = false
	elif dir == Vector2i.LEFT:
		$AnimatedSprite2D.animation = "walk_sides"
		$AnimatedSprite2D.flip_h = false
	else:
		$AnimatedSprite2D.animation = "walk_sides"
		$AnimatedSprite2D.flip_h = true
	
	$AnimatedSprite2D.play();
	$AnimatedSprite2D.stop();
	
	$AnimatedSprite2D.frame = 0;

func move (d: Vector2i, u: int) -> Signal:
	dir = d;
	units = u;
	
	if d == Vector2i.UP:
		$AnimatedSprite2D.animation = "walk_up"
		$AnimatedSprite2D.flip_v = false
	elif d == Vector2i.DOWN:
		$AnimatedSprite2D.animation = "walk_down"
		$AnimatedSprite2D.flip_v = false
	elif d == Vector2i.LEFT:
		$AnimatedSprite2D.animation = "walk_sides"
		$AnimatedSprite2D.flip_h = false
	else:
		$AnimatedSprite2D.animation = "walk_sides"
		$AnimatedSprite2D.flip_h = true
		
	$AnimatedSprite2D.play();
	
	return destination_reached
