defmodule PhoenixChallenge.Repo.Migrations.CreateThreads do
  use Ecto.Migration

  def change do
    create table(:threads) do
      add :title, :string
      add :content, :text
      add :author, :string

      timestamps()
    end
  end
end
