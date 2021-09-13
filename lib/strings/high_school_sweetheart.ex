defmodule Exercism.Strings.HighSchoolSweetheart do
  @moduledoc """
  In this exercise, you are going to help high school sweethearts profess their love on social media by generating an ASCII heart with their initials:

       ******       ******
   **      **   **      **
  **         ** **         **
  **            *            **
  **                         **
  **     J. K.  +  M. B.     **
  **                       **
   **                   **
     **               **
       **           **
         **       **
           **   **
             ***
              *
  """

  @spec first_letter(binary) :: binary
  @doc """
  Implement the HighSchoolSweetheart.first_letter/1 function. It should take a name and return its first letter. It should clean up any unnecessary whitespace from the name.

  ## Example
    iex> HighSchoolSweetheart.first_letter("Jane")
    "J"
  """
  def first_letter(name) do
    name
    |> String.trim()
    |> String.first()
  end

  @spec initial(binary) :: nonempty_binary
  @doc """
  Implement the HighSchoolSweetheart.initial/1 function. It should take a name and return its first letter, uppercase, followed by a dot. Make sure to reuse HighSchoolSweetheart.first_letter/1 that you defined in the previous step.

  ## Example
    iex> HighSchoolSweetheart.initial("Robert")
    "R."
  """
  def initial(name) do
    name
    |> first_letter()
    |> String.upcase()
    |> Kernel.<>(".")
  end

  @doc """
  Implement the HighSchoolSweetheart.initials/1 function. It should take a full name, consisting of a first name and a last name separated by a space, and return the initials. Make sure to reuse HighSchoolSweetheart.initial/1 that you defined in the previous step.

  ## Example
    iex> HighSchoolSweetheart.initials("Lance Green")
    "L. G."
  """
  def initials(full_name) do
    full_name
    |> String.split()
    |> Enum.map(fn x -> initial(x) end)
    |> List.insert_at(1, " ")
    |> List.to_string()
  end

  @spec pair(binary, binary) :: binary
  @doc """
  Implement the HighSchoolSweetheart.pair/2 function. It should take two full names and return the initials. Make sure to reuse HighSchoolSweetheart.initials/1 that you defined in the previous step.
  """
  def pair(full_name1, full_name2) do
    initial_1 = initials(full_name1)
    initial_2 = initials(full_name2)

    """
         ******       ******
       **      **   **      **
     **         ** **         **
    **            *            **
    **                         **
    **     #{initial_1}  +  #{initial_2}     **
     **                       **
       **                   **
         **               **
           **           **
             **       **
               **   **
                 ***
                  *
    """
  end
end
