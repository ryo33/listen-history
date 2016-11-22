defmodule Musiclog.Repo.Migrations.CreateUser do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :name, :string
      add :display, :string
      add :provider, :string
      add :provided_id, :string
      add :api_key, :string

      timestamps()
    end
    create unique_index(:users, [:name])
    create unique_index(:users, [:provided_id])

  end
end
