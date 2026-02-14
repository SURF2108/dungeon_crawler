extends PanelContainer

signal slot_clicked(index: int, button: int)
@onready var quantity: Label = $Quantity
@onready var texture_rect: TextureRect = $MarginContainer/TextureRect


func set_slot_data(slot_data: Slot_data)->void:
	if not slot_data or not slot_data.Item_data: # tarun here
		texture_rect.texture = null # tarun here
		quantity.hide() # tarun here
		return # tarun here
		
	var item_data= slot_data.Item_data
	texture_rect.texture=item_data.texture
	
	if slot_data.quantity > 1:
		quantity.text=str(slot_data.quantity)
		quantity.show()
	else:
		quantity.hide()
	


func _on_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and (event.button_index==MOUSE_BUTTON_LEFT or event.button_index==MOUSE_BUTTON_RIGHT )and event.is_pressed():
		slot_clicked.emit(get_index(), event.button_index)

func _on_mouse_entered() -> void: # tarun here
	modulate = Color(1.2, 1.2, 1.2) # tarun here

func _on_mouse_exited() -> void: # tarun here
	modulate = Color(1, 1, 1) # tarun here
