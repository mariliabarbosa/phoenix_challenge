defmodule PhoenixChallengeWeb.ReplyView do
  use PhoenixChallengeWeb, :view
  alias PhoenixChallengeWeb.ReplyView

  def render("index.json", %{replies: replies}) do
    %{data: render_many(replies, ReplyView, "reply.json")}
  end

  def render("show.json", %{reply: reply}) do
    %{data: render_one(reply, ReplyView, "reply.json")}
  end

  def render("reply.json", %{reply: reply}) do
    %{
      id: reply.id,
      content: reply.content,
      author: reply.author,
      thread_id: reply.thread_id
    }
  end
end
