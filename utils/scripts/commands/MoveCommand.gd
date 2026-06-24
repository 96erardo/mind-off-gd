class_name MoveCommand extends Command

var m_actor: Character;
var m_dir: Vector2i;
var m_units: int;

const DIRECTIONS = {
	"UP": Vector2i.UP,
	"DOWN": Vector2i.DOWN,
	"LEFT": Vector2i.LEFT,
	"RIGHT": Vector2i.RIGHT
} 
	
func _init (actor: Character, dir: Vector2, units: int):
	m_actor = actor
	m_dir = dir
	m_units = units

static func from_step (scene: Scene, step: CutSceneStep) -> Command:
	return MoveCommand.new(
		scene.get_actor(step.character),
		DIRECTIONS[step.dir],
		step.value
	)

func execute ():
	await m_actor.move(m_dir, m_units);
