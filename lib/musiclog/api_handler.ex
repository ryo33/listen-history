defmodule Musiclog.APIHandler do
  alias Musiclog.Repo
  alias Musiclog.Artist
  alias Musiclog.Album
  alias Musiclog.Song
  alias Musiclog.Play

  def play(user, params) do
    params = case params do
      %{"album" => album_name,
        "artist" => artist_name, "song" => song_name} ->
        {:ok, {album_name, artist_name, song_name}}
      _ -> {:error, 400, "invalid"}
    end
    with {:ok, {album_name, artist_name, song_name}} <- params,
         {:ok, artist} <- ensure_artist_exists(user, artist_name),
         {:ok, song} <- ensure_song_exists(user, artist, album_name, song_name),
         {:ok, play} <- add_log(user, song) do
      {:ok, 200, %{play_id: play.id}}
    else
      {:error, status_code, reason} ->
        {:error, status_code, %{reason: reason}}
    end
  end

  def ensure_artist_exists(user, name) do
    case Repo.get_by(Artist, name: name) do
      nil ->
        params = %{user_id: user.id, name: name}
        changeset = Artist.changeset(%Artist{}, params)
        case Repo.insert(changeset) do
          {:ok, artist} -> {:ok, artist}
          {:error, _changeset} -> {:error, 400, "invalid"}
        end
      artist -> {:ok, artist}
    end
  end

  def ensure_song_exists(user, artist, album, name) do
    case Repo.get_by(Song, artist_id: artist.id, album: album, name: name) do
      nil ->
        params = %{user_id: user.id, artist_id: artist.id, album: album, name: name}
        changeset = Song.changeset(%Song{}, params)
        case Repo.insert(changeset) do
          {:ok, song} -> {:ok, song}
          {:error, _changeset} -> {:error, 400, "invalid"}
        end
      song -> {:ok, song}
    end
  end

  def add_log(user, song) do
    changeset = Play.changeset(%Play{}, %{user_id: user.id, song_id: song.id})
    case Repo.insert(changeset) do
        {:ok, play} -> {:ok, play}
        {:error, _changeset} -> {:error, 400, "invalid"}
    end
  end
end

