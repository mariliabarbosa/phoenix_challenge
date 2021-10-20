defmodule PhoenixChallenge.Repo.Migrations.CreateReplies do
  use Ecto.Migration

  def change do
    create table(:replies) do
      add :thread_id, references(:threads)
      add :content, :text
      add :author, :string

      timestamps()
    end
  end
end
