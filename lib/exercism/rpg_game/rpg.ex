defmodule Exercism.RPGGame.RPG do
  @moduledoc """
  You're developing your own role-playing video game. In your game, there are characters and items. One of the many actions that you can do with an item is to make a character eat it.

  Not all items are edible, and not all edible items have the same effects on the character. Some items, when eaten, turn into a different item (e.g. if you eat an apple, you are left with an apple core).

  To allow for all that flexibility, you decided to create an Edible protocol that some of the items can implement.

  """
  alias __MODULE__

  defmodule Character do
    defstruct health: 100, mana: 0
  end

  defmodule LoafOfBread do
    defstruct []
  end

  defmodule ManaPotion do
    defstruct strength: 10
  end

  defmodule Poison do
    defstruct []
  end

  defmodule EmptyBottle do
    defstruct []
  end

  # Create the RPG.Edible protocol. The protocol has one function - eat. The eat function accepts an item and a character and returns a by-product and a character.

  # Implement the RPG.Edible protocol for the RPG.LoafOfBread item. When eaten, a loaf of bread gives the character 5 health points and has no by-product.

  # ### Example

  # iex> RPG.Edible.eat(%RPG.LoafOfBread{}, %RPG.Character{health: 31})
  # {nil, %RPG.Character{health: 36, mana: 0}}

  # Implement the RPG.Edible protocol for the RPG.ManaPotion item. When eaten, a mana potion gives the character as many mana points as the potion's strength, and produces an empty bottle.

  # ### Example

  # iex> RPG.Edible.eat(%RPG.ManaPotion{strength: 13}, %RPG.Character{mana: 50})
  # {%RPG.EmptyBottle{}, %RPG.Character{health: 100, mana: 63}}

  # Implement the RPG.Edible protocol for the RPG.Poison item. When eaten, a poison takes away all the health points from the character, and produces an empty bottle.

  # ### Example

  # iex> RPG.Edible.eat(%RPG.Poison{}, %RPG.Character{health: 3000})
  # {%RPG.EmptyBottle{}, %RPG.Character{health: 0, mana: 0}}

  defprotocol Edible do
    @spec eat(struct, struct) :: tuple
    def eat(item, character)
  end

  defimpl Edible, for: LoafOfBread do
    @spec eat(struct, struct) :: {nil, map}
    def eat(%RPG.LoafOfBread{}, %RPG.Character{} = character) do
      {nil, Map.update!(character, :health, &(&1 + 5))}
    end
  end

  defimpl Edible, for: ManaPotion do
    @spec eat(struct, struct) :: {%RPG.EmptyBottle{}, map}
    def eat(%RPG.ManaPotion{} = item, %RPG.Character{} = character) do
      {%RPG.EmptyBottle{}, Map.update!(character, :mana, &(&1 + item.strength))}
    end
  end

  defimpl Edible, for: Poison do
    @spec eat(struct, struct) :: {%RPG.EmptyBottle{}, map}
    def eat(%RPG.Poison{}, %RPG.Character{} = character) do
      {%RPG.EmptyBottle{}, Map.update!(character, :health, &(&1 * 0))}
    end
  end
end
