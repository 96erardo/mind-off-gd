extends Scene

var path = ""
var cutscene: CutScenePlayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	commands = {
		"move": MoveCommand,
		"turn": TurnCommand,
		"wait": WaitCommand,
		"talk": TalkCommand
	};
	
	cutscene = CutScenePlayer.new(
		path if path else "res://utils/scripts/cutscene/end.tres", 
		self
	)
	
	await cutscene.run();
	
	Transition.fade_to_scene(
		"res://office/scenes/sign.tscn",
	)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass;
