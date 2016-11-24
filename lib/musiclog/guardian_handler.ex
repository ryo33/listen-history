defmodule Musiclog.GuardianHandler do
  use Phoenix.Controller

  def unauthenticated(conn, params) do
    conn
    |> put_flash(:error, "Authentication required")
    |> redirect(to: "/login")
  end
end
