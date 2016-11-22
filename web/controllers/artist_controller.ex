defmodule Musiclog.ArtistController do
  use Musiclog.Web, :controller

  alias Musiclog.Artist

  def index(conn, _params) do
    query = from artist in Artist,
      order_by: [desc: artist.updated_at],
      limit: 100
    artists = Repo.all(query)
    render(conn, "index.html", artists: artists)
  end

  def show(conn, %{"id" => id}) do
    query = from artist in Artist,
      where: artist.id == ^id
    artist = Repo.one!(query)
    render(conn, "show.html", artist: artist)
  end
end
