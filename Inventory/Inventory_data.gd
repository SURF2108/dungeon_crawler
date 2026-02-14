extends Resource


class_name Inventory_data

signal inventory_updated(inventory_data: Inventory_data)
signal inventory_interact(inventory_data: Inventory_data, index: int, button: int)


@export var slot_data: Array[Slot_data]

func grab_slot_data(index: int) -> Slot_data:
	var slot_dat= slot_data[index]
	
	if slot_dat: # tarun here
		slot_data[index]=null
		inventory_updated.emit(self)
		
		return slot_dat
	else:
		return null
	
func drop_slot_data(grabbed_slot_data: Slot_data,index: int) -> Slot_data:
	var slot_dat= slot_data[index]
	
	var return_slot_data: Slot_data
	
	if slot_dat and slot_dat.can_fully_merge_with(grabbed_slot_data):
		slot_dat.fully_merge_with(grabbed_slot_data)
	else:
		slot_data[index]=grabbed_slot_data
		return_slot_data= slot_dat
	
	inventory_updated.emit(self)
	return return_slot_data

func use_slot_data(index: int) -> void: # tarun here
	var slot_dat = slot_data[index] # tarun here
	
	if not slot_dat: # tarun here
		return # tarun here
		
	if slot_dat.Item_data: # tarun here
		slot_dat.Item_data.use(null) 
		
		if slot_dat.quantity > 1: # tarun here
			slot_dat.quantity -= 1 # tarun here
		else: 
			slot_data[index] = null 
		
		inventory_updated.emit(self) # tarun here


 

func on_slot_clicked( index: int, button: int) -> void:
	inventory_interact.emit(self, index, button)
	print("clicked")

func add_item(item: Resource, count: int = 1) -> bool:
	var item_to_add = item as Item_data
	if not item_to_add:
		return false
		
	for slot in slot_data:
		if slot and slot.Item_data == item_to_add and slot.Item_data.stakable:
			slot.quantity += count
			inventory_updated.emit(self)
			return true
	
	for i in range(slot_data.size()):
		if slot_data[i] == null:
			var new_slot = Slot_data.new()
			new_slot.Item_data = item_to_add
			new_slot.quantity = count
			slot_data[i] = new_slot
			inventory_updated.emit(self)
			return true
			
	return false
