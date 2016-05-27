defmodule Palacios.FormularioController do
  use Palacios.Web, :controller

  alias Palacios.Formulario

  plug :scrub_params, "formulario" when action in [:create, :update]

  def index(conn, _params) do
    formulario = Repo.all(Formulario)
    render(conn, "index.html", formulario: formulario)
  end

  def new(conn, _params) do
    changeset = Formulario.changeset(%Formulario{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"formulario" => formulario_params}) do
    changeset = Formulario.changeset(%Formulario{}, formulario_params)

    case Repo.insert(changeset) do
      {:ok, _formulario} ->
        conn
        |> put_flash(:info, "Formulario created successfully.")
        |> redirect(to: formulario_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    formulario = Repo.get!(Formulario, id)
    render(conn, "show.html", formulario: formulario)
  end

  def edit(conn, %{"id" => id}) do
    formulario = Repo.get!(Formulario, id)
    changeset = Formulario.changeset(formulario)
    render(conn, "edit.html", formulario: formulario, changeset: changeset)
  end

  def update(conn, %{"id" => id, "formulario" => formulario_params}) do
    formulario = Repo.get!(Formulario, id)
    changeset = Formulario.changeset(formulario, formulario_params)

    case Repo.update(changeset) do
      {:ok, formulario} ->
        conn
        |> put_flash(:info, "Formulario updated successfully.")
        |> redirect(to: formulario_path(conn, :show, formulario))
      {:error, changeset} ->
        render(conn, "edit.html", formulario: formulario, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    formulario = Repo.get!(Formulario, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(formulario)

    conn
    |> put_flash(:info, "Formulario deleted successfully.")
    |> redirect(to: formulario_path(conn, :index))
  end
end
