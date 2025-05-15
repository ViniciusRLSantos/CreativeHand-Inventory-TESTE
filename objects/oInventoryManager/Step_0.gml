inventory.InventoryUpdate();


if (inventory.IsOpen()) {
  exit;
}

if (!is_struct(global.selectedSlot)) {
  exit
}

if (InputPressed(INPUT_VERB.ACTION)) {
  global.selectedSlot.UseItem();
}
