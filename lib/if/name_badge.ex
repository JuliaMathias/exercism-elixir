defmodule Exercism.If.NameBadge do
  @moduledoc """
  In this exercise you'll be writing code to print name badges for factory employees. Employees have an ID, name, and department name. Employee badge labels are formatted as follows: "[id] - name - DEPARTMENT".
  """

  @spec print(any, any, nil | binary) :: binary
  @doc """
  Implement the NameBadge.print/3 function. It should take an id, name, and a department. It should return the badge label, with the department name in uppercase.

  Due to a quirk in the computer system, new employees occasionally don't yet have an ID when they start working at the factory. As badges are required, they will receive a temporary badge without the ID prefix.

  Extend the NameBadge.print/3 function. When the id is missing, it should print a badge without it.

  Even the factory's owner has to wear a badge at all times. However, an owner does not have a department. In this case, the label should print "OWNER" instead of the department name.

  Extend the NameBadge.print/3 function. When the department is missing, assume the badge belongs to the company owner.

  ## Examples
    iex> NameBadge.print(67, "Katherine Williams", "Strategic Communication")
    "[67] - Katherine Williams - STRATEGIC COMMUNICATION"
    iex> NameBadge.print(nil, "Robert Johnson", "Procurement")
    "Robert Johnson - PROCUREMENT"
    iex> NameBadge.print(204, "Rachel Miller", nil)
    "[204] - Rachel Miller - OWNER"
  """
  def print(id, name, nil) do
    if is_nil(id) do
      "#{name} - OWNER"
    else
      "[#{id}] - #{name} - OWNER"
    end
  end

  def print(id, name, department) do
    uppercase_dep = String.upcase(department)

    if is_nil(id) do
      "#{name} - #{uppercase_dep}"
    else
      "[#{id}] - #{name} - #{uppercase_dep}"
    end
  end
end
