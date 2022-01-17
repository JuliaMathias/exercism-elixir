defmodule Exercism.Constants.Garden do
  @moduledoc """
  Given a diagram, determine which plants each child in the kindergarten class is responsible for.

  The kindergarten class is learning about growing plants. The teacher thought it would be a good idea to give them actual seeds, plant them in actual dirt, and grow actual plants.

  They've chosen to grow grass, clover, radishes, and violets.

  To this end, the children have put little cups along the window sills, and planted one type of plant in each cup, choosing randomly from the available types of seeds.

  ```
  [window][window][window]
  ........................ # each dot represents a cup
  ........................
  ```

  There are 12 children in the class:

  - Alice, Bob, Charlie, David,
  - Eve, Fred, Ginny, Harriet,
  - Ileana, Joseph, Kincaid, and Larry.

  Each child gets 4 cups, two on each row. Their teacher assigns cups to the children alphabetically by their names.

  The following diagram represents Alice's plants:

  ```
  [window][window][window]
  VR......................
  RG......................
  ```


  In the first row, nearest the windows, she has a violet and a radish. In the second row she has a radish and some grass.

  Your program will be given the plants from left-to-right starting with the row nearest the windows. From this, it should be able to determine which plants belong to each student.

  For example, if it's told that the garden looks like so:

  ```
  [window][window][window]
  VRCGVVRVCGGCCGVRGCVCGCGV
  VRCCCGCRRGVCGCRVVCVGCGCV
  ```


  Then if asked for Alice's plants, it should provide:

  Violets, radishes, violets, radishes
  While asking for Bob's plants would yield:

  Clover, grass, clover, clover
  """

  @student_names [
    :alice,
    :bob,
    :charlie,
    :david,
    :eve,
    :fred,
    :ginny,
    :harriet,
    :ileana,
    :joseph,
    :kincaid,
    :larry
  ]

  @student_map %{
    alice: {},
    bob: {},
    charlie: {},
    david: {},
    eve: {},
    fred: {},
    ginny: {},
    harriet: {},
    ileana: {},
    joseph: {},
    kincaid: {},
    larry: {}
  }

  @plants %{"V" => :violets, "R" => :radishes, "C" => :clover, "G" => :grass}

  @doc """
    Accepts a string representing the arrangement of cups on a windowsill and a
    list with names of students in the class. The student names list does not
    have to be in alphabetical order.

    It decodes that string into the various gardens for each student and returns
    that information in a map.
  """

  @spec info(String.t(), list) :: map
  def info(info_string, student_names \\ @student_names) do
    {sorted_student_names, student_map} = get_student_names_and_student_map(student_names)

    do_info(info_string, sorted_student_names, student_map)
  end

  defp get_student_names_and_student_map(student_names) do
    if student_names != @student_names do
      sorted_names = sort_names(student_names)

      student_map =
        sorted_names
        |> Enum.map(fn x -> {x, {}} end)
        |> Enum.into(%{})

      {sorted_names, student_map}
    else
      {@student_names, @student_map}
    end
  end

  defp sort_names(student_names) do
    student_names
    |> Enum.map(fn x -> Atom.to_string(x) end)
    |> Enum.sort()
    |> Enum.map(fn x -> String.to_atom(x) end)
  end

  defp do_info(info_string, student_names, student_map) when is_binary(info_string) do
    [row1, row2] = String.split(info_string, "\n")

    rows = {split_and_chunk(row1), split_and_chunk(row2)}

    do_info(rows, student_names, student_map)
  end

  defp do_info({[], []}, _student_names, student_map), do: student_map

  defp do_info({[head1 | tail1], [head2 | tail2]}, [student | rest], student_map) do
    plants_tuple = get_plants(head1, head2) |> List.to_tuple()

    new_student_map = Map.replace!(student_map, student, plants_tuple)

    do_info({tail1, tail2}, rest, new_student_map)
  end

  defp split_and_chunk(list) do
    list
    |> String.split("", trim: true)
    |> Enum.chunk_every(2)
  end

  defp get_plants(list1, list2) do
    Enum.map(list1, fn x -> Map.get(@plants, x) end) ++
      Enum.map(list2, fn x -> Map.get(@plants, x) end)
  end
end
