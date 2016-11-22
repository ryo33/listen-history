defmodule Musiclog.APIController do
  use Musiclog.Web, :controller

  plug Guardian.Plug.EnsureAuthenticated, %{handler: __MODULE__} when action in [:play, :logout]

  def login(conn, params) do
    import Poison
    user = case params do
      %{"user" => user_id, "secret" => key} ->
        Repo.get_by(Musiclog.User, id: user_id, api_key: key)
      _ ->
        nil
    end

    if not is_nil(user) do
      new_conn = Guardian.Plug.api_sign_in(conn, user)
      jwt = Guardian.Plug.current_token(new_conn)
      {:ok, claims} = Guardian.Plug.claims(new_conn)
      exp = Map.get(claims, "exp") |> encode!()

      new_conn
      |> put_status(201)
      |> put_resp_header("authorization", "Bearer #{jwt}")
      |> put_resp_header("x-expires", exp)
      |> render "login.json", user: encode!(user), token: encode!(jwt), exp: exp
    else
      conn
      |> put_status(401)
      |> render "error.json", message: "Could not login"
    end
  end

  def play(conn, params) do
    user = Guardian.Plug.current_resource(conn)
    case Musiclog.APIHandler.play(user, params) do
      {:ok, status, body} ->
        send_resp(conn, status, body |> Poison.encode!())
      {:error, status, body} ->
        send_resp(conn, status, body |> Poison.encode!())
    end
  end

  def logout(conn, _params) do
    jwt = Guardian.Plug.current_token(conn)
    claims = Guardian.Plug.claims(conn)
    Guardian.revoke!(jwt, claims)
    render "logout.json"
  end

  def unauthenticated(conn, _params) do
    conn
    |> put_status(401)
    |> render "error.json", message: "Authentication required"
  end
end
