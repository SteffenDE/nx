defmodule Exla.Shape do
  alias __MODULE__, as: Shape

  @enforce_keys [:ref]
  defstruct [:ref, dims: nil, dtype: nil]

  # TODO: convert dtype to integer representation to use in NIF
  def make_shape(dtype, dims) when is_atom(dtype) do
    {:ok, ref} = Exla.NIF.make_shape(dtype, dims)
    %Shape{ref: ref, dtype: dtype, dims: dims}
  end

  def str_to_dtype(str) do
    {type, size} = Enum.split(str, 1)
    {List.to_atom(type), List.to_integer(size)}
  end
end
