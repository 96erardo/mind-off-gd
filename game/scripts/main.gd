extends Scene

var path: String;
var cutscene: CutScenePlayer;
var game: Game;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	commands = {
		"wait": WaitCommand,
		"talk": TalkCommand,
		"slide_in": SlideImageCommand,
		"slide_out": HideImageCommand,
		"change_img": ChangeImageCommand,
		"play": PlayCommand
	};
	
	game = Game.new(0, 0);
	update_score();
	
	cutscene = CutScenePlayer.new(
		path if path else "res://utils/scripts/cutscene/during.tres",
		self
	)
		
	await cutscene.run();

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func start () -> Signal:
	$ResetTimer.start()
	
	return game.start()

func update_score () -> void:
	$LScore.text = str(game.getLeftPoints());
	$RScore.text = str(game.getRightPoints());
	
func _on_ball_timer_timeout() -> void:
	if game.status == Game.Status.PLAYING:
		$Ball.serve(game.whosNext())
	elif game.status == Game.Status.WON:
		Transition.fade_to_scene(
			"res://office/scenes/office_end.tscn",
			{ "path": "res://utils/scripts/cutscene/end.tres" }
		);
	elif game.status == Game.Status.LOST:
		Transition.fade_to_scene(
			"res://game/scenes/game_over.tscn"
		);
	
func _on_reset_timer_timeout() -> void:
	$Ball.reset()
	$BallTimer.start()

func _on_left_score_body_entered(body: Node2D) -> void:
	game.addRightPoint()
	
	update_score()
	
	$ResetTimer.start();

func _on_right_score_body_entered(body: Node2D) -> void:
	game.addLeftPoint();
	
	update_score()

	$ResetTimer.start();
	
func score_to_text () -> String:
	return str(game.getLeftPoints()) + "-" + str(game.getRightPoints());
