extends Control
@onready var player_inventory: PanelContainer = $Player_inventory
@onready var grabbed_slot: PanelContainer = $grabbed_Slot

var grabbed_slot_data: Slot_data
# Called when the node enters the scene tree for the first time.

func _physics_process(delta: float) -> void:
	if grabbed_slot.visible:
		grabbed_slot.global_position=get_global_mouse_position() + Vector2(5,5)
		
		
func set_player_inventory_data(inventory_data: Inventory_data)->void:
	if not inventory_data.inventory_interact.is_connected(on_inventory_interact): 
		inventory_data.inventory_interact.connect(on_inventory_interact) 
	player_inventory.set_inventory_data(inventory_data)
	
	
func on_inventory_interact(inventory_data: Inventory_data, index: int, button: int)->void:
	# tarun here: Handling different interaction cases
	match [grabbed_slot_data, button]:
		[null, MOUSE_BUTTON_LEFT]:
			grabbed_slot_data = inventory_data.grab_slot_data(index)
		[_, MOUSE_BUTTON_LEFT]:
			grabbed_slot_data = inventory_data.drop_slot_data(grabbed_slot_data, index)
		[null, MOUSE_BUTTON_RIGHT]: # tarun here: Use item
			inventory_data.use_slot_data(index) # tarun here
		[_, MOUSE_BUTTON_RIGHT]: # tarun here: Drop a single item from stack
			pass # Could implement split stack here
			
	update_grabbed_slot() # tarun here

		
		
func update_grabbed_slot() -> void: # tarun here
	if grabbed_slot_data:
		grabbed_slot.show()
		grabbed_slot.set_slot_data(grabbed_slot_data)
	else:
		grabbed_slot.hide()
