defmodule Palacios.PinedaController do
  use Palacios.Web, :controller

  alias Palacios.Pineda

  plug :scrub_params, "pineda" when action in [:create, :update]

  def index(conn, _params) do
    pineda = Repo.all(Pineda)
    render(conn, "index.html", pineda: pineda)
  end

  def new(conn, _params) do
    changeset = Pineda.changeset(%Pineda{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"pineda" => pineda_params}) do
    changeset = Pineda.changeset(%Pineda{}, pineda_params)

    case Repo.insert(changeset) do
      {:ok, _pineda} ->
        conn
        |> put_flash(:info, "Pineda created successfully.")
        |> redirect(to: pineda_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    pineda = Repo.get!(Pineda, id)
    render(conn, "show.html", pineda: pineda)
  end

  def edit(conn, %{"id" => id}) do
    pineda = Repo.get!(Pineda, id)
    changeset = Pineda.changeset(pineda)
    render(conn, "edit.html", pineda: pineda, changeset: changeset)
  end

  def update(conn, %{"id" => id, "pineda" => pineda_params}) do
    pineda = Repo.get!(Pineda, id)
    changeset = Pineda.changeset(pineda, pineda_params)

    case Repo.update(changeset) do
      {:ok, pineda} ->
        conn
        |> put_flash(:info, "Pineda updated successfully.")
        |> redirect(to: pineda_path(conn, :show, pineda))
      {:error, changeset} ->
        render(conn, "edit.html", pineda: pineda, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    pineda = Repo.get!(Pineda, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(pineda)

    conn
    |> put_flash(:info, "Pineda deleted successfully.")
    |> redirect(to: pineda_path(conn, :index))
  end
end
