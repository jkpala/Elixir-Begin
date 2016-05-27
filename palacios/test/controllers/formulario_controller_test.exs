defmodule Palacios.FormularioControllerTest do
  use Palacios.ConnCase

  alias Palacios.Formulario
  @valid_attrs %{bio: "some content", email: "some content", name: "some content", number_of_pets: 42}
  @invalid_attrs %{}

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, formulario_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing formulario"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, formulario_path(conn, :new)
    assert html_response(conn, 200) =~ "New formulario"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, formulario_path(conn, :create), formulario: @valid_attrs
    assert redirected_to(conn) == formulario_path(conn, :index)
    assert Repo.get_by(Formulario, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, formulario_path(conn, :create), formulario: @invalid_attrs
    assert html_response(conn, 200) =~ "New formulario"
  end

  test "shows chosen resource", %{conn: conn} do
    formulario = Repo.insert! %Formulario{}
    conn = get conn, formulario_path(conn, :show, formulario)
    assert html_response(conn, 200) =~ "Show formulario"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, formulario_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    formulario = Repo.insert! %Formulario{}
    conn = get conn, formulario_path(conn, :edit, formulario)
    assert html_response(conn, 200) =~ "Edit formulario"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    formulario = Repo.insert! %Formulario{}
    conn = put conn, formulario_path(conn, :update, formulario), formulario: @valid_attrs
    assert redirected_to(conn) == formulario_path(conn, :show, formulario)
    assert Repo.get_by(Formulario, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    formulario = Repo.insert! %Formulario{}
    conn = put conn, formulario_path(conn, :update, formulario), formulario: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit formulario"
  end

  test "deletes chosen resource", %{conn: conn} do
    formulario = Repo.insert! %Formulario{}
    conn = delete conn, formulario_path(conn, :delete, formulario)
    assert redirected_to(conn) == formulario_path(conn, :index)
    refute Repo.get(Formulario, formulario.id)
  end
end
