#region Item Type Constructors

function Item() constructor {
  name = "";
  sprite = noone;
  damage = 0;
  description = "";
  stackLimit = 64;
  consumable = true;
  tag = "Item"
  info = "";
  Action = function() { };
  
  __ResetInfo = function() { };
}

function Tool() : Item() constructor {
  tag = "Tool";
  info = $"[c_smaragdine]+{damage} DMG[/c] [expression_attack]";
  __ResetInfo = function() {
    info = $"[c_smaragdine]+{damage} DMG[/c] [expression_attack]";
  }
  stackLimit = 1;
  consumable = false;
}

function Food() : Item() constructor {
  hpAdd = 1;
  staminaAdd = 1;
  tag = "Food"
  info = $"[c_lime]+{hpAdd}HP[/c][expression_love] | [c_yellow]+{staminaAdd} STM[/c][expression_confused_1]";
  __ResetInfo = function() {
    info = $"[c_lime]+{hpAdd}HP[/c][expression_love] | [c_yellow]+{staminaAdd} STM[/c][expression_confused_1]";;
  }
  Action = function() {
    show_debug_message($"Ate {name} and recovered {hpAdd} HP and {staminaAdd} STM");
  }
}
#endregion


#region Item Constructors
function Sword() : Tool() constructor {
  name = "Sword";
  sprite = sword;
  damage = 6;
  description = "A sharp weapon";
  Action = function() {
    show_debug_message("*swings sword* You may or may not have hit something");
  }
  __ResetInfo();
}

function FishingRod() : Tool() constructor {
  name = "Fishing rod";
  sprite = rod;
  damage = 2;
  description = "Try catching a [c_aqua]Gyarados[/c]!";
  
  Action = function() {
    show_debug_message("*Throws rod* You may or may not catch a fish")
  }
  __ResetInfo();
}

function Radish() : Food() constructor {
  name = "Radish";
  sprite = radish_05;
  hpAdd = 4;
  staminaAdd = 4;
  description = "Nice looking [c_red]red[/c] veggie.";
  __ResetInfo();
}

function Carrot() : Food() constructor {
  name = "Carrot";
  sprite = carrot_05;
  hpAdd = 5;
  staminaAdd = 4;
  description = "Bunnies [wave]LOVE[/wave] these things!";
  __ResetInfo();
}

function Fish() : Food() constructor {
  name = "Fish";
  sprite = fish;
  hpAdd = 7;
  staminaAdd = 10;
  description = "A tasty sea meal.";
  __ResetInfo();
}
#endregion

