global.selectedSlot = noone;

#region Slot Constructor
function Slot(_x, _y) constructor {
  #region Private
  __selected = false;
  __mouseHovered = false;
  #endregion
  
  #region Public
  x = _x;
  y = _y;
  item = noone;
  itemAmount = 0;
  
  SetItem = function(_item) {
    item = _item;
  }
  
  GetItem = function() {
    return item;
  }
  
  GetItemAmount = function() {
    return itemAmount;
  }
  
  GetStackLimit = function() {
    if (item == noone) {
      return 0;
    }
    return item.stackLimit;
  }
  
  EmptySlot = function() {
    self.SetItem(noone);
    itemAmount = 0;
  }
  
  AddItem = function(_item, _amount=1) {
    if (item == noone) {
      self.SetItem(_item)
    }
    itemAmount += _amount;
  }
  
  IsEmpty = function() {
    return (item == noone);
  }
  
  UseItem = function() {
    if (self.IsEmpty()) {
      return;
    }
    
    self.item.Action();
    if (self.item.consumable) {
      self.itemAmount--;
      if (self.itemAmount <= 0) {
        self.EmptySlot();
        global.selectedSlot = noone;
      }
    }
  }
  
  SlotUpdate = function() {
    var _mouseX = InputMouseGuiX();
    var _mouseY = InputMouseGuiY();
	
  	if (point_in_rectangle(_mouseX, _mouseY, x, y, x+SLOT_SIZE, y+SLOT_SIZE)) {
  	  __mouseHovered = true;
  	} else {
  	  __mouseHovered = false;
  	}
	
    if (__mouseHovered) {
      if (item == noone) {
        
        return;
      }
  	  if (InputMousePressed(mb_left) && global.selectedSlot != self) {
        __selected = true;
        global.selectedSlot = self
      }
  	}
  }
  
  SlotDraw = function() {
    draw_sprite_stretched_ext(sBoxWhite, 0, x, y, SLOT_SIZE, SLOT_SIZE, -1, 0.5);
    
    if (self.IsEmpty()) {
      return;
    }
    draw_sprite(item.sprite, 0, x+SLOT_SIZE/2, y+SLOT_SIZE/2);
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    draw_text(x+SLOT_SIZE, y+SLOT_SIZE, $"{self.itemAmount}");
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
    
    if (__mouseHovered) {
      
      var _boxWidth = 100;
      var _boxMaxHeight = 192;
      var _boxMargin = 10;
      
      var _screenMargin = 24;
      
      var _text = $"[c_coquelicot]{item.tag}[/c]\n[/]{item.description}\n[/]{item.info}";
      var _scribble = scribble(_text);
      _scribble.starting_format("fntMain", c_white);
      _scribble.wrap(_boxWidth, _boxMaxHeight);
      
      var _boxHeight = string_height_scribble(_text);
      var _posX = RESOLUTION_WIDTH - _boxWidth - _screenMargin;
      var _posY = RESOLUTION_HEIGHT/2 - 60;
      draw_sprite_stretched(sBoxBrown, 0, _posX-_boxMargin, _posY-_boxMargin, _boxWidth+2*_boxMargin, _boxHeight+2*_boxMargin);
      _scribble.draw(_posX, _posY);
    }
    
  }
  #endregion
}
#endregion


#region Inventory Constructor
function Inventory(_lines, _columns) constructor {
  #region Private
  __open = false;
  __marginH = 10;
  __marginV = 10;
  __padding = 5;
  __lines = _lines;
  __columns = _columns;
  __width = 2*__marginH + __padding*(__columns-1) + __columns*SLOT_SIZE;
  __height = 2*__marginV + __padding*(__lines-1) + __lines*SLOT_SIZE;
  
  __posX = abs(RESOLUTION_WIDTH/2 - __width/2);
  __posY = abs(RESOLUTION_HEIGHT/2 - __height/2);
  
  __grid = ds_grid_create(__columns, __lines);
  
  for (var _i=0; _i<__columns; _i++) {
    for (var _j=0; _j<__lines; _j++) {
      __grid[# _i, _j] = new Slot(__posX+__marginH+_i*(SLOT_SIZE+__padding), __posY+__marginV+_j*(SLOT_SIZE+__padding));
    }
  }
  
  __GetSameItemSlot = function(_item) {
    var _slot = noone;
    var _i = 0;
    var _j = 0;
    var _itemType = instanceof(_item);
    
    while (_i < self.__columns+1 && _j < self.__lines) {
      var _currentSlot = self.__grid[# _i, _j];
      var _currentItemType = instanceof(_currentSlot.item);
      
      if (_currentItemType == _itemType && _currentSlot.GetItemAmount() < _currentSlot.GetStackLimit()) {
        _slot = _currentSlot;
        break;
      }
      
      _i++;
      if (_i>=__columns) {
        _i = 0;
        _j++;
      }
    }
    return _slot;
  }
  
  __GetEmptySlot = function() {
    var _slot = noone;
    var _i = 0;
    var _j = 0;
    
    while (_i < self.__columns+1 && _j < self.__lines) {
      var _currentSlot = self.__grid[# _i, _j];
      
      if (_currentSlot.IsEmpty()) {
        _slot = _currentSlot;
        break;
      }
      
      _i++;
      if (_i>=__columns) {
        _i = 0;
        _j++;
      }
    }
    return _slot;
  }
  
  __GetAvailableSlot = function(_item) {
    var _slot = __GetSameItemSlot(_item);
    
    if (_slot == noone) {
      _slot = __GetEmptySlot();
    }
    
    return _slot;
  }
  #endregion
  
  #region Public
  IsOpen = function() {
    return self.__open;
  }
  
  InventoryUpdate = function() {
    if (InputPressed(INPUT_VERB.OPEN_INVENTORY)) {
      __open = !__open;
    }
    
    if (!__open) {
      return;
    }
    
    for (var _i=0; _i<__columns; _i++) {
      for (var _j=0; _j<__lines; _j++) {
        __grid[# _i, _j].SlotUpdate();
      }
    }
  }
  
  InventoryDraw = function() {
    if (!__open) {
      return;
    }
    
    draw_sprite_stretched(sBoxBrown, 0, __posX, __posY, __width, __height);
    for (var _i=0; _i<__columns; _i++) {
      for (var _j=0; _j<__lines; _j++) {
        __grid[# _i, _j].SlotDraw();
      }
    }
  }
  
  InventoryInsert = function(_item, _amount=1) {
    var _slot = self.__GetAvailableSlot(_item);
    
    if (is_struct(_slot)) {
      var _stock = _slot.GetItemAmount();
      var _newStock = _stock + _amount;
      
      if (_newStock <= _item.stackLimit) {
        _slot.AddItem(_item, _amount);
        return;
      }
      var _difference = _slot.GetStackLimit() - _stock;
      var _remain = _amount - _difference;
      _slot.AddItem(_item, _difference);
      self.InventoryInsert(_item, _remain);
    }
  }
  
  InventoryCleanUp = function() {
    if (ds_exists(self.__grid, ds_type_grid)) {
      ds_grid_destroy(self.__grid);
    }
  }
  #endregion
}
#endregion

