# UI-Inventory-TESTE
Possui um menu de debug para testes onde você pode acrescentar qualquer item listado na quantidade que deseja (de 1-20).

##Controles
- I: Abrir/Fechar inventário
- Mouse: Selecionar slot
- Barra de Espaço: Executar ação do item

## Estrutura Básica
Decidi optar organizar a estrutura da seguinte forma:

> Struct Slot que irá conter um tipo de Struct Item.

> Struct Inventário que irá conter um ds_grid contendo Struct Slot.

### Item
> _Item()

Struct pai para criar os tipos de itens e consequentemente os itens em si. Configurável em _scrItemsConfig_

>Exemplo

```gml
function Utility() : Item() constructor {
  hpAdd = 0;
  staminaAdd = 0;
  consumable = true;
  // ...
}

function HealthPotion() : Utility() constructor {
  hpAdd = 50;
  // ...
}
```

**Propriedades Básicas**
- **_.name_** (string):
  - Nome do item
- **_.sprite_** (GMAsset.Sprite):
  - Sprite relacionado ao item
- **_.description_** (string):
  - Descrição do item
- **_.stackLimit_** (Integer):
  - Limite do item dentro de um slot
- **_.tag_** (string):
  - Classificação do item
- **_.info_** (string):
  - Informação do item (quanto de dano vai causar, quanta vida vai restaurar, etc.)

**Métodos**
- **_.Action_**:
  - Ação que o item irá executar ao ser usado

### Slot
> _global.selectedSlot_: Representa o slot que foi selecionado dentro de um inventário.

> Slot(x, y)
Struct para armazenar um único tipo de item. O tamanho do slot é uma constante definida em _scrConstants_

**Propriedades Básicas**
- **_.x_** (Real):
  - Coordenada x do slot
- **_.y_** (Real):
  - Coordenada y do slot
- **_.item_** (Struct.Item, noone):
  - Struct de item armazenado dentro do slot. Caso o slot esteja vazio, retorna _noone_.
- **_.itemAmount_** (Integer):
  - Quantidade do item dentro do slot

**Métodos**
- **_.SetItem(item)_**:
  - Seta o item dentro do slot.
- **_.GetItem()_** -> {Struct.item, noone}:
  - Retorna o struct do item dentro do slot ou noone caso esteja vazio
- **_.GetItemAmount()_** -> {Integer}:
  - Retorna a quantidade de itens dentro do slot.
- **_.EmptySlot()_**:
  - Esvazia o slot e reseta a variável global _global.selectedSlot_ para _noone_
- **_.UseItem()_**:
  - Executa o método _.Action()_ do item armazenado dentro do slot
- **_.SlotUpdate()_**:
  - Basicamente o evento Step do slot. Atualiza os dados do slot. Se o mouse passou por cima e se foi clicado, atualiza a variável global _global.selectedSlot_ para si mesmo.
- **_.SlotDraw()_**:
  - Evento draw do slot.
### Inventory
> Inventory(columns, lines)

Struct do inventário. Armazena vários slots dentro de um ds_grid. Para alterar a aparência ou configurar margens e espaçamento entre os slots basta alterar as propriedades privadas. (Assumindo que só irá existir um único inventário.)

**Métodos**
- **_.IsOpen() -> (boolean)_**:
  - Verifica se o inventário está aberto ou não.
- **_.InventoryUpdate()_**:
  - Atualiza os dados do inventário. Deve ser colocado em algum dos eventos step.
- **_.InventoryDraw()_**:
  - Desenha o inventário na tela. Deve ser colocado no evento Draw GUI
- **_.InventoryInsert(item, amount)_**:
  - Busca um ou mais slots disponíveis dentro do inventário e insere uma quantidade, especificada no parâmetro _amount_, de um item, especificado no parâmetro _item_.
- **_.InventoryCleanUp()_**:
  - Deleta o ds_grid. Este método DEVE sempre existir dentro do evento Clean Up.
