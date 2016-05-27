defmodule Palacios.PinedaControllerTest do
  use Palacios.ConnCase

  alias Palacios.Pineda
  @valid_attrs %{bio: "some content", email: "some content", name: "some content", number_of_pets: 42}
  @invalid_attrs %{}

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, pineda_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing pineda"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, pineda_path(conn, :new)
    assert html_response(conn, 200) =~ "New pineda"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, pineda_path(conn, :create), pineda: @valid_attrs
    assert redirected_to(conn) == pineda_path(conn, :index)
    assert Repo.get_by(Pineda, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, pineda_path(conn, :create), pineda: @invalid_attrs
    assert html_response(conn, 200) =~ "New pineda"
  end

  test "shows chosen resource", %{conn: conn} do
    pineda = Repo.insert! %Pineda{}
    conn = get conn, pineda_path(conn, :show, pineda)
    assert html_response(conn, 200) =~ "Show pineda"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, pineda_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    pineda = Repo.insert! %Pineda{}
    conn = get conn, pineda_path(conn, :edit, pineda)
    assert html_response(conn, 200) =~ "Edit pineda"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    pineda = Repo.insert! %Pineda{}
    conn = put conn, pineda_path(conn, :update, pineda), pineda: @valid_attrs
    assert redirected_to(conn) == pineda_path(conn, :show, pineda)
    assert Repo.get_by(Pineda, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    pineda = Repo.insert! %Pineda{}
    conn = put conn, pineda_path(conn, :update, pineda), pineda: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit pineda"
  end

  test "deletes chosen resource", %{conn: conn} do
    pineda = Repo.insert! %Pineda{}
    conn = delete conn, pineda_path(conn, :delete, pineda)
    assert redirected_to(conn) == pineda_path(conn, :index)
    refute Repo.get(Pineda, pineda.id)
  end
end
