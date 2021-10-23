defmodule PhoenixChallenge.Forum do
  @moduledoc """
  The Forum context.
  """

  import Ecto.Query, warn: false
  alias PhoenixChallenge.Repo

  alias PhoenixChallenge.Forum.Thread

  def list_threads do
    Repo.all(Thread)
  end

  def get_thread!(id), do: Repo.get!(Thread, id)

  def create_thread(attrs \\ %{}) do
    %Thread{}
    |> Thread.changeset(attrs)
    |> Repo.insert()
  end

  alias PhoenixChallenge.Forum.Reply

   def list_replies!(thread_id) do
    from(r in Reply, where: r.thread_id == ^thread_id)
    |> Repo.all()
    |> Repo.preload(threads: :replies)
  end

  def create_reply(attrs, thread_id) do
    attrs = Map.put(attrs, "thread_id", thread_id)
    %Reply{}
    |> Reply.changeset(attrs)
    |> Repo.insert()
  end
end
