defmodule Exercism.AST.TopSecretTest do
  use ExUnit.Case
  alias Exercism.AST.TopSecret
  doctest Exercism.AST.TopSecret

  describe "decode_secret_message/1" do
    test "should decode message in module with two functions" do
      code = """
      defmodule MyCalendar do
        def busy?(date, time) do
          Date.day_of_week(date) != 7 and
            time.hour in 10..16
        end

        def yesterday?(date) do
          Date.diff(Date.utc_today, date)
        end
      end
      """

      assert TopSecret.decode_secret_message(code) == "buy"
    end

    test "should decode message in module with one function" do
      code =
        "defmodule Notebook do\n  def note(notebook, text) do\n    add_to_notebook(notebook, text, append: true)\n  end\nend\n"

      assert TopSecret.decode_secret_message(code) == "no"
    end

    test "should decode message in module without module definition" do
      code =
        "def force(mass, acceleration), do: mass * acceleration\ndef uniform(from, to), do: rand.uniform(to - from) + from\ndef data(%{metadata: metadata}, _opts), do: model(metadata)\ndefp model(metadata, _opts), do: metadata |> less_data |> Enum.reverse() |> Enum.take(3)\ndefp less_data(data, _opts), do: Enum.reject(data, &is_nil/1)\n"

      assert TopSecret.decode_secret_message(code) == "foundamole"
    end

    test "should decode message in multiple modules" do
      code =
        "defmodule IOHelpers do\n  def inspect(x, opts), do: IO.inspect(x, opts)\n  def vi_or_vim(_env, _preference), do: :vim\n  def signal(pid, string), do: send(pid, {:signal, string})\n  def black(text, label), do: IO.ANSI.black <> label <> text <> IO.ANSI.reset()\nend\n\ndefmodule TimeHelpers do\n  defp est_to_cet(time), do: Time.add(time, 6 * 60 * 60)\nend\n\ndefmodule ASTHelpers do\n  def submodule?(m, _f, _args), do: String.contains?(m, \".\")\n  def module({m, _f, _args}), do: m\n  def arity(_m, _f, args), do: length(args)\n  defp nested?(x, y) when is_list(y), do: x in y\nend\n"

      assert TopSecret.decode_secret_message(code) == "invisiblesubmarine"
    end
  end
end
