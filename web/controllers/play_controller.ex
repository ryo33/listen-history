defmodule Musiclog.PlayController do
  use Musiclog.Web, :controller

  alias Musiclog.Play

  def index(conn, _params) do
    query = from play in Play,
      preload: ^Play.preload_params,
      order_by: [desc: play.updated_at],
      limit: 100
    plays = Repo.all(query)
    render(conn, "index.html", plays: plays)
  end

  def show(conn, %{"id" => id}) do
    query = from play in Play,
      preload: ^Play.preload_params,
      where: play.id == ^id
    play = Repo.one!(query)
    render(conn, "show.html", play: play)
  end
end
