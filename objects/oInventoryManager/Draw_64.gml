inventory.InventoryDraw();

draw_sprite_stretched(sBoxBrown, 0, 12, 12, 32, 40);
draw_sprite_stretched(sBoxWhite, 0, 16, 16, 24, 24);
if (is_struct(global.selectedSlot)) {
  
  if (!is_struct(global.selectedSlot.item)) {
    exit;
  }
  draw_sprite(global.selectedSlot.item.sprite, 0, 28, 28);
  var _scribble = scribble($"[rainbow]{global.selectedSlot.GetItemAmount()}");
  _scribble.align(fa_center, fa_top);
  _scribble.starting_format("fntMain", c_white);
  _scribble.draw(28, 36);
}



