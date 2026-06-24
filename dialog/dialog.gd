class_name Dialog extends Control

signal text_read;

enum NamePosition {
	LEFT,
	RIGHT,
	CENTER
}

var is_typing: bool = false;
var complete_text: String = "";

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if visible && Input.is_action_just_pressed("enter"):
		if is_typing:
			is_typing = false;
		else:
			visible = false;
			text_read.emit();

func showDialog (name: String, text: String, position: NamePosition = NamePosition.LEFT):
	if position == NamePosition.LEFT:
		$NameBox.anchor_left = 0;
		$NameBox.anchor_right = 0;
		$NameBox.offset_left = 15;
		$NameBox.offset_right = 79;
		$NameBox/Name.horizontal_alignment = HorizontalAlignment.HORIZONTAL_ALIGNMENT_LEFT
	elif position == NamePosition.RIGHT:
		$NameBox.anchor_left = 1;
		$NameBox.anchor_right = 1;
		$NameBox.offset_left = -79;
		$NameBox.offset_right = -20;
		$NameBox/Name.horizontal_alignment = HorizontalAlignment.HORIZONTAL_ALIGNMENT_LEFT
	elif position == NamePosition.CENTER:
		$NameBox.anchor_left = 0.5;
		$NameBox.anchor_right = 0.5;
		$NameBox.offset_left = -29;
		$NameBox.offset_right = 30;
		
	_typeMessage(name, text)
	
	return text_read


func _typeMessage (name: String, text: String):
	var nameNode = $NameBox/Name
	var contentNode = $DialogBox/ScrollContainer/Text
	
	contentNode.visible_characters = 0;
	
	nameNode.text = name;
	contentNode.text = text;
	
	visible = true
	is_typing = true
	
	for i in text.length():
		contentNode.visible_characters += 1;
		await get_tree().create_timer(0.03).timeout
		
		if not is_typing:
			break
			
	contentNode.visible_characters = text.length();
	is_typing = false;
	
	
