defmodule Musiclog.Repo.Migrations.CreateSong do
  use Ecto.Migration

  def change do
    create table(:songs) do
      add :name, :string
      add :album, :string
      add :user_id, references(:users, on_delete: :nothing), null: false
      add :artist_id, references(:artists, on_delete: :nothing), null: false

      timestamps()
    end
    create index(:songs, [:user_id])
    create index(:songs, [:artist_id])

  end
end
