defmodule Exercism.Behaviour.DancingDots.Animation do
  @moduledoc """
  Instructions
  Your friend, an aspiring artist, reached out to you with a project idea. Let's combine his visual creativity with your technical expertise. It's time to dabble in generative art!

  Constraints help creativity and shorten project deadlines, so you've both agreed to limit your masterpiece to a single shape - the circle. But there's going to be many circles. And they can move around! You'll call it... dancing dots.

  Your friend will definitely want to come up with new elaborate movements for the dots, so you'll start coding by creating an architecture that will allow you to later define new animations easily.

  Each animation module needs to implement two callbacks: init/1 and handle_frame/3. Define them in the Animation module.

  Define the init/1 callback. It should take one argument of type opts and return either an {:ok, opts} tuple or {:error, error} tuple. Implementations of this callback will check if the given options are valid for this particular type of animation.

  Define the handle_frame/3 callbacks. It should take three arguments - the dot, a frame number, and options. It should always return a dot. Implementations of this callback will modify the dot's attributes based on the current frame number and the animation's options.
  """
  @type dot :: DancingDots.Dot.t()
  @type opts :: keyword
  @type error :: any
  @type frame_number :: pos_integer

  @callback init(opts) :: {:ok, opts} | {:error, error}
  @callback handle_frame(dot, frame_number, opts) :: dot

  @doc """
  The Animation behaviour should be easy to incorporate into other modules by calling use DancingDots.Animation.

  To make that happen, implement the __using__ macro in the Animation module so that it sets the Animation module as the other module's behaviour. It should also provide a default implementation of the init/1 callback. The default implementation of init/1 should return the given options unchanged.

  ### Example

    defmodule MyCustomAnimation do
      use DancingDots.Animation
    end

  iex> MyCustomAnimation.init([some_option: true])
  {:ok, [some_option: true]}
  """
  defmacro __using__(_) do
    quote do
      @behaviour Exercism.Behaviour.DancingDots.Animation
      def init(opts), do: {:ok, opts}
      defoverridable init: 1
    end
  end
end

defmodule Exercism.Behaviour.DancingDots.Flicker do
  @moduledoc """
  Use the Animation behaviour to implement a flickering animation.

  It should use the default init/1 callback because it doesn't take any options.
  """

  use Exercism.Behaviour.DancingDots.Animation

  @doc """
  Implement the handle_frame/3 callback. In every 4th frame, it should return the dot with half of its original opacity. In other frames, it should return the dot unchanged.

  Frames are counted from 1. The dot passed to handle_frame/3 is always the dot in its original state, not in the state from the previous frame.

  ### Example

  iex> dot = %DancingDots.Dot{x: 100, y: 100, radius: 24, opacity: 1}
  iex> DancingDots.Flicker.handle_frame(dot, 1, [])
  %DancingDots.Dot{opacity: 1, radius: 24, x: 100, y: 100}
  iex> DancingDots.Flicker.handle_frame(dot, 4, [])
  %DancingDots.Dot{opacity: 0.5, radius: 24, x: 100, y: 100}

  """
  @impl true
  def handle_frame(dot, frame_number, _opts) when rem(frame_number, 4) == 0 do
    Map.replace!(dot, :opacity, dot.opacity / 2)
  end

  def handle_frame(dot, _frame_number, _opts), do: dot
end

defmodule Exercism.Behaviour.DancingDots.Zoom do
  @moduledoc """
  Use the Animation behaviour to implement a zooming animation.

  This animation takes one option - velocity. Velocity can be any number. If it's negative, the dot gets zoomed out instead of zoomed in.
  """

  use Exercism.Behaviour.DancingDots.Animation

  @doc """
  Implement the init/1 callback. It should validate that the passed options is a keyword list with a :velocity key. The value of velocity must be a number. If it's not a number, return the error

  ```
  The :velocity option is required, and its value must be a number. Got: :whatever
  ```

  ### Example

  iex> DancingDots.Zoom.init([velocity: nil])
  {:error, "Expected required option :velocity to be a number, got: nil"}
  """
  @impl true
  def init([velocity: velocity] = opts) when is_number(velocity) do
    {:ok, opts}
  end

  def init(velocity: velocity) do
    {:error,
     "The :velocity option is required, and its value must be a number. Got: #{inspect(velocity)}"}
  end

  def init(_),
    do: {:error, "The :velocity option is required, and its value must be a number. Got: nil"}

  @doc """
    Implement the handle_frame/3 callback. It should return the dot with its radius increased by the current frame number, minus one, times velocity.

  Frames are counted from 1. The dot passed to handle_frame/3 is always the dot in its original state, not in the state from the previous frame.

  ### Example

  iex> dot = %DancingDots.Dot{x: 100, y: 100, radius: 24, opacity: 1}
  iex> DancingDots.Zoom.handle_frame(dot, 1, [velocity: 10])
  %DancingDots.Dot{radius: 24, opacity: 1, x: 100, y: 100}

  iex> DancingDots.Zoom.handle_frame(dot, 2, [velocity: 10])
  %DancingDots.Dot{radius: 34, opacity: 1, x: 100, y: 100}
  """
  @impl true
  def handle_frame(dot, frame_number, velocity: velocity) do
    Map.replace!(dot, :radius, dot.radius + (frame_number - 1) * velocity)
  end
end
