class_name TurnCommand extends Command

var m_actor: Character;
var m_dir: Vector2i;

const DIRECTIONS = {
	"UP": Vector2i.UP,
	"DOWN": Vector2i.DOWN,
	"LEFT": Vector2i.LEFT,
	"RIGHT": Vector2i.RIGHT
}

func _init(actor: Character, direction: Vector2i) -> void:
	m_actor = actor;
	m_dir = direction;

static func from_step (scene: Scene, step: TurnStep) -> Command:
	return TurnCommand.new(scene.get_actor(step.character), DIRECTIONS[step.dir])


func execute ():
	m_actor.turn(m_dir);
