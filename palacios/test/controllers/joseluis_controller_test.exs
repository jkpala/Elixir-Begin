defmodule Palacios.JoseluisControllerTest do
  use Palacios.ConnCase

  alias Palacios.Joseluis
  @valid_attrs %{bio: "some content", email: "some content", name: "some content", number_of_pets: 42}
  @invalid_attrs %{}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, joseluis_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    joseluis = Repo.insert! %Joseluis{}
    conn = get conn, joseluis_path(conn, :show, joseluis)
    assert json_response(conn, 200)["data"] == %{"id" => joseluis.id,
      "name" => joseluis.name,
      "email" => joseluis.email,
      "bio" => joseluis.bio,
      "number_of_pets" => joseluis.number_of_pets}
  end

  test "does not show resource and instead throw error when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, joseluis_path(conn, :show, -1)
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, joseluis_path(conn, :create), joseluis: @valid_attrs
    assert json_response(conn, 201)["data"]["id"]
    assert Repo.get_by(Joseluis, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, joseluis_path(conn, :create), joseluis: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    joseluis = Repo.insert! %Joseluis{}
    conn = put conn, joseluis_path(conn, :update, joseluis), joseluis: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(Joseluis, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    joseluis = Repo.insert! %Joseluis{}
    conn = put conn, joseluis_path(conn, :update, joseluis), joseluis: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    joseluis = Repo.insert! %Joseluis{}
    conn = delete conn, joseluis_path(conn, :delete, joseluis)
    assert response(conn, 204)
    refute Repo.get(Joseluis, joseluis.id)
  end
end
