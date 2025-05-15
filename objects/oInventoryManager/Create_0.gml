inventory = new Inventory(3, 5);
inventory.InventoryInsert(new Carrot(), 200);
inventory.InventoryInsert(new Fish(), 10);
display_set_gui_size(RESOLUTION_WIDTH, RESOLUTION_HEIGHT);

#region Debug Testing
enum ITEM {
  RADISH=0,
  CARROT=1,
  FISH=2,
  FISHING_ROD=3,
  SWORD=4
}

invDebug = dbg_view("Inventory Commands", true);
invDbgSection = dbg_section("Add Items");
invDbgAdd = 5;
invDbgItemType = ITEM.RADISH;

invDbgFuncAdd = function() {
  switch(invDbgItemType) {
    case ITEM.RADISH:
    inventory.InventoryInsert(new Radish(), invDbgAdd);
    break;
    case ITEM.CARROT:
    inventory.InventoryInsert(new Carrot(), invDbgAdd);
    break;
    case ITEM.FISH:
    inventory.InventoryInsert(new Fish(), invDbgAdd);
    break;
    case ITEM.FISHING_ROD:
    inventory.InventoryInsert(new FishingRod(), invDbgAdd);
    break;
    case ITEM.SWORD:
    inventory.InventoryInsert(new Sword(), invDbgAdd);
    break;
  }
}

dbg_drop_down(ref_create(self,"invDbgItemType"), "Radish:0,Carrot:1,Fish:2,Fishing_Rod:3,Sword:4","Item Type");
dbg_slider_int(ref_create(self, "invDbgAdd"), 1, 20, "Amount");
dbg_button("Add", invDbgFuncAdd)
#endregion

