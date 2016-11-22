defmodule Musiclog.Repo.Migrations.CreateArtist do
  use Ecto.Migration

  def change do
    create table(:artists) do
      add :name, :string
      add :user_id, references(:users, on_delete: :nothing), null: false

      timestamps()
    end
    create unique_index(:artists, [:name])
    create index(:artists, [:user_id])

  end
end
