class_name ImageViewer extends Control

@onready var anim = $AnimationPlayer
@onready var img = $TextureRect

func _ready() -> void:
	pass

func slide_in (path: String) -> void:
	img.texture = load(path)
	
	anim.play("Slide_In");
	
	await anim.animation_finished

func slide_out () -> void:
	anim.play("Slide_Out");
	
	await anim.animation_finished

func change (path: String) -> void:
	img.texture = load(path)
