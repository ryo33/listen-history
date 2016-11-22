defmodule Musiclog.Repo.Migrations.CreatePlay do
  use Ecto.Migration

  def change do
    create table(:plays) do
      add :user_id, references(:users, on_delete: :nothing), null: false
      add :song_id, references(:songs, on_delete: :nothing), null: false

      timestamps()
    end
    create index(:plays, [:user_id])
    create index(:plays, [:song_id])

  end
end
