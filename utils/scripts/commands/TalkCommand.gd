class_name TalkCommand extends Command

var m_scene: Scene
var m_name: String
var m_text: String
var m_pos: Dialog.NamePosition

func _init (scene: Scene, name: String, text: String, pos: Dialog.NamePosition = Dialog.NamePosition.LEFT) -> void:
	m_scene = scene;
	m_name = name;
	m_text = text;
	m_pos = pos;

static func from_step (scene: Scene, step: TalkStep) -> Command:
	return TalkCommand.new(scene, step.name, step.text, step.pos);
	
func execute ():
	await m_scene.talk(m_name, m_text, m_pos)
