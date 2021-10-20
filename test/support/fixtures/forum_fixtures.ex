defmodule PhoenixChallenge.ForumFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `PhoenixChallenge.Forum` context.
  """

  @doc """
  Generate a thread.
  """
  def thread_fixture(attrs \\ %{}) do
    {:ok, thread} =
      attrs
      |> Enum.into(%{
        author: "some author",
        content: "some content",
        title: "some title"
      })
      |> PhoenixChallenge.Forum.create_thread()

    thread
  end

  @doc """
  Generate a reply.
  """
  def reply_fixture(attrs \\ %{}) do
    {:ok, reply} =
      attrs
      |> Enum.into(%{
        author: "some author",
        content: "some content"
      })
      |> PhoenixChallenge.Forum.create_reply()

    reply
  end
end
