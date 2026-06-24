class_name Scene extends Node

@onready var dialogUI: Dialog = get_node("CanvasLayer/Dialog")
@onready var imageViewer: ImageViewer = get_node("ImageViewer")

var commands: Dictionary[String, Variant];

func has_command (name: String) -> bool:
	return commands.has(name)

func get_actor (name: String) -> Character:
	return get_node("Objects/" + name);

func talk (name: String, text: String, pos: Dialog.NamePosition = Dialog.NamePosition.LEFT) -> void:
	await dialogUI.showDialog(name, text, pos);

func wait (time: float) -> void:
	await get_tree().create_timer(time).timeout

func slide_image (path: String) -> void:
	await imageViewer.slide_in(path)
