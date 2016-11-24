defmodule Musiclog.PlayController do
  use Musiclog.Web, :controller

  alias Musiclog.Play

  plug Guardian.Plug.EnsureAuthenticated, %{handler: Musiclog.GuardianHandler} when action in [:delete]

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

  def delete(conn, %{"id" => id}) do
    user = Guardian.Plug.current_resource(conn)
    Repo.get_by!(Play, user_id: user.id, id: id)
    |> Repo.delete!()
    conn
    |> put_flash(:info, "Successfully deleted")
    |> redirect(to: "/users/#{user.name}/")
  end
end
