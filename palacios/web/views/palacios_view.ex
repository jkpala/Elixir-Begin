defmodule Palacios.PalaciosView do
  use Palacios.Web, :view

  def render("index.json", %{palacios: palacios}) do
    %{data: render_many(palacios, Palacios.PalaciosView, "palacios.json")}
  end

  def render("show.json", %{palacios: palacios}) do
    %{data: render_one(palacios, Palacios.PalaciosView, "palacios.json")}
  end

  def render("palacios.json", %{palacios: palacios}) do
    %{id: palacios.id,
      name: palacios.name,
      email: palacios.email,
      bio: palacios.bio,
      number_of_pets: palacios.number_of_pets}
  end
end
