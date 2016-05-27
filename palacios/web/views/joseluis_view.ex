defmodule Palacios.JoseluisView do
  use Palacios.Web, :view

  def render("index.json", %{joseluis: joseluis}) do
    %{data: render_many(joseluis, Palacios.JoseluisView, "joseluis.json")}
  end

  def render("show.json", %{joseluis: joseluis}) do
    %{data: render_one(joseluis, Palacios.JoseluisView, "joseluis.json")}
  end

  def render("joseluis.json", %{joseluis: joseluis}) do
    %{id: joseluis.id,
      name: joseluis.name,
      email: joseluis.email,
      bio: joseluis.bio,
      number_of_pets: joseluis.number_of_pets}
  end
end
