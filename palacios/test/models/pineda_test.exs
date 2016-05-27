defmodule Palacios.PinedaTest do
  use Palacios.ModelCase

  alias Palacios.Pineda

  @valid_attrs %{bio: "some content", email: "some content", name: "some content", number_of_pets: 42}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Pineda.changeset(%Pineda{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Pineda.changeset(%Pineda{}, @invalid_attrs)
    refute changeset.valid?
  end
end
