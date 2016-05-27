defmodule Palacios.JoseluisController do
  use Palacios.Web, :controller

  alias Palacios.Joseluis

  plug :scrub_params, "joseluis" when action in [:create, :update]

  def index(conn, _params) do
    joseluis = Repo.all(Joseluis)
    render(conn, "index.json", joseluis: joseluis)
  end

  def create(conn, %{"joseluis" => joseluis_params}) do
    changeset = Joseluis.changeset(%Joseluis{}, joseluis_params)

    case Repo.insert(changeset) do
      {:ok, joseluis} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", joseluis_path(conn, :show, joseluis))
        |> render("show.json", joseluis: joseluis)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Palacios.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    joseluis = Repo.get!(Joseluis, id)
    render(conn, "show.json", joseluis: joseluis)
  end

  def update(conn, %{"id" => id, "joseluis" => joseluis_params}) do
    joseluis = Repo.get!(Joseluis, id)
    changeset = Joseluis.changeset(joseluis, joseluis_params)

    case Repo.update(changeset) do
      {:ok, joseluis} ->
        render(conn, "show.json", joseluis: joseluis)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Palacios.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    joseluis = Repo.get!(Joseluis, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(joseluis)

    send_resp(conn, :no_content, "")
  end
end
