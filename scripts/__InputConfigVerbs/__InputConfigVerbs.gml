function __InputConfigVerbs()
{
  enum INPUT_VERB
  {
    //Add your own verbs here!
    ACTION,
    OPEN_INVENTORY
  }
    
  enum INPUT_CLUSTER
  {
    //Add your own clusters here!
    //Clusters are used for two-dimensional checkers (InputDirection() etc.)
    NAVIGATION,
  }
    
  InputDefineVerb(INPUT_VERB.OPEN_INVENTORY,  "open_inventory", ord("I"), gp_select);
  InputDefineVerb(INPUT_VERB.ACTION,  "action", vk_space, gp_face3);
}