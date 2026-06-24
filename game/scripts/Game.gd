class_name Game extends RefCounted

signal game_finished;

enum Status {
	NOT_STARTED,
	PLAYING,
	WON,
	LOST
}

enum Turn {
	LEFT =   1,
	RIGHT = -1
}

var status: Status = Status.PLAYING;
var score: Array[int] = [0, 0];
var serves = 0;
var serves_per_player = 2;
var turn: Turn = Turn.LEFT;

func _init(lScore: int = 0, rScore: int = 0) -> void:
	score[0] = lScore;
	score[1] = rScore;
	
func start () -> Signal:
	return game_finished;

func whosNext () -> Turn:
	if serves % serves_per_player == 0:
		turn = Turn.RIGHT if turn == Turn.LEFT else Turn.LEFT;
	
	serves += 1;
	
	return turn;
	
func _on_point () -> void:
	if score[0] == 10 && score[1] == 10:
		serves = 1
	elif score[0] > 10 && abs(score[0] - score[1]) >= 2:
		status = Status.WON
		game_finished.emit();
	elif score[1] > 10 && abs(score[1] - score[0]) >= 2:
		status = Status.LOST
		game_finished.emit();

func addLeftPoint () -> void:
	score[0] += 1;
	_on_point()

func addRightPoint () -> void:
	score[1] += 1;
	_on_point()

func getLeftPoints () -> int:
	return score[0];

func getRightPoints () -> int:
	return score[1];
