defmodule Musiclog.UserController do
  use Musiclog.Web, :controller

  alias Musiclog.User
  alias Musiclog.Play

  plug Guardian.Plug.EnsureAuthenticated, %{handler: Musiclog.GuardianHandler} when action in [:api_key, :update_api_key]

  def api_key(conn, _params) do
    user = Guardian.Plug.current_resource(conn)
    render(conn, "api-key.html", user: user)
  end

  def update_api_key(conn, _params) do
    user = Guardian.Plug.current_resource(conn)
    changeset = User.changeset(user, %{api_key: User.generate_api_key()})
    user = Repo.update!(changeset)
    redirect(conn, to: "/api-key")
  end

  def index(conn, _params) do
    users = Repo.all(User)
    render(conn, "index.html", users: users)
  end

  def show(conn, %{"id" => name}) do
    user = Repo.get_by!(User, name: name)
    query = from play in Play,
      where: play.user_id == ^user.id,
      preload: ^Play.preload_params,
      order_by: [desc: play.updated_at],
      limit: 100
    plays = Repo.all(query)
    render(conn, "show.html", user: user, plays: plays)
  end

  def edit(conn, %{"id" => name}) do
    user = Repo.get_by!(User, name: name)
    changeset = User.changeset(user)
    render(conn, "edit.html", user: user, changeset: changeset)
  end

  def update(conn, %{"id" => name, "user" => user_params}) do
    user = Repo.get_by!(User, name: name)
    changeset = User.changeset(user, user_params)

    case Repo.update(changeset) do
      {:ok, user} ->
        conn
        |> put_flash(:info, "User updated successfully.")
        |> redirect(to: user_path(conn, :show, user))
      {:error, changeset} ->
        render(conn, "edit.html", user: user, changeset: changeset)
    end
  end
end
