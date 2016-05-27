defmodule Palacios.PalaciosController do
  use Palacios.Web, :controller

  alias Palacios.Palacios

  plug :scrub_params, "palacios" when action in [:create, :update]

  def index(conn, _params) do
    palacios = Repo.all(Palacios)
    render(conn, "index.json", palacios: palacios)
  end

  def create(conn, %{"palacios" => palacios_params}) do
    changeset = Palacios.changeset(%Palacios{}, palacios_params)

    case Repo.insert(changeset) do
      {:ok, palacios} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", palacios_path(conn, :show, palacios))
        |> render("show.json", palacios: palacios)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Palacios.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    palacios = Repo.get!(Palacios, id)
    render(conn, "show.json", palacios: palacios)
  end

  def update(conn, %{"id" => id, "palacios" => palacios_params}) do
    palacios = Repo.get!(Palacios, id)
    changeset = Palacios.changeset(palacios, palacios_params)

    case Repo.update(changeset) do
      {:ok, palacios} ->
        render(conn, "show.json", palacios: palacios)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Palacios.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    palacios = Repo.get!(Palacios, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(palacios)

    send_resp(conn, :no_content, "")
  end
end
