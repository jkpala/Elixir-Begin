defmodule Palacios.PalaciosControllerTest do
  use Palacios.ConnCase

  alias Palacios.Palacios
  @valid_attrs %{bio: "some content", email: "some content", name: "some content", number_of_pets: 42}
  @invalid_attrs %{}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, palacios_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    palacios = Repo.insert! %Palacios{}
    conn = get conn, palacios_path(conn, :show, palacios)
    assert json_response(conn, 200)["data"] == %{"id" => palacios.id,
      "name" => palacios.name,
      "email" => palacios.email,
      "bio" => palacios.bio,
      "number_of_pets" => palacios.number_of_pets}
  end

  test "does not show resource and instead throw error when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, palacios_path(conn, :show, -1)
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, palacios_path(conn, :create), palacios: @valid_attrs
    assert json_response(conn, 201)["data"]["id"]
    assert Repo.get_by(Palacios, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, palacios_path(conn, :create), palacios: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    palacios = Repo.insert! %Palacios{}
    conn = put conn, palacios_path(conn, :update, palacios), palacios: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(Palacios, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    palacios = Repo.insert! %Palacios{}
    conn = put conn, palacios_path(conn, :update, palacios), palacios: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    palacios = Repo.insert! %Palacios{}
    conn = delete conn, palacios_path(conn, :delete, palacios)
    assert response(conn, 204)
    refute Repo.get(Palacios, palacios.id)
  end
end
