defmodule PhoenixChallenge.Forum.Reply do
  use Ecto.Schema
  import Ecto.Changeset

  schema "replies" do
    field :author, :string
    field :content, :string

    belongs_to :threads, PhoenixChallenge.Forum.Thread

    timestamps()
  end

  @doc false
  def changeset(reply, attrs) do
    reply
    |> cast(attrs, [:content, :author, :thread_id])
    |> validate_required([:content, :author, :thread_id])
  end
end
