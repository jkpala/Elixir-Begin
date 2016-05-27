defmodule Palacios.FormularioTest do
  use Palacios.ModelCase

  alias Palacios.Formulario

  @valid_attrs %{bio: "some content", email: "some content", name: "some content", number_of_pets: 42}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Formulario.changeset(%Formulario{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Formulario.changeset(%Formulario{}, @invalid_attrs)
    refute changeset.valid?
  end
end
