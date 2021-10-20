defmodule PhoenixChallenge.Forum.Thread do
  use Ecto.Schema
  import Ecto.Changeset

  schema "threads" do
    field :author, :string
    field :content, :string
    field :title, :string

    has_many :replies, PhoenixChallenge.Forum.Reply

    timestamps()
  end

  @doc false
  def changeset(thread, attrs) do
    thread
    |> cast(attrs, [:title, :content, :author])
    |> validate_required([:title, :content, :author])
  end
end
