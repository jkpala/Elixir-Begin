defmodule Palacios.JoseluisTest do
  use Palacios.ModelCase

  alias Palacios.Joseluis

  @valid_attrs %{bio: "some content", email: "some content", name: "some content", number_of_pets: 42}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Joseluis.changeset(%Joseluis{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Joseluis.changeset(%Joseluis{}, @invalid_attrs)
    refute changeset.valid?
  end
end
