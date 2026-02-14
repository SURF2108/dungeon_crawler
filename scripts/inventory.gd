extends PanelContainer

@onready var item_grid: GridContainer = $MarginContainer/item_grid

const SLOT_SCENE = preload("res://ui/slot.tscn")

func _ready() -> void:
	var inv_data = preload("res://Inventory/test_inv.tres")
	grid_builder(inv_data)
	
func set_inventory_data(inventory_data: Inventory_data) -> void:
	inventory_data.inventory_updated.connect(grid_builder)
	grid_builder(inventory_data)
	
func grid_builder(inventory_data: Inventory_data) -> void:
	for child in item_grid.get_children():
		child.queue_free()
		
	for Slot_data in inventory_data.slot_data :
		var slot_instance = SLOT_SCENE.instantiate() 
		item_grid.add_child(slot_instance) 
		
		slot_instance.slot_clicked.connect(inventory_data.on_slot_clicked) 
		
		if Slot_data: 
			slot_instance.set_slot_data(Slot_data) 
