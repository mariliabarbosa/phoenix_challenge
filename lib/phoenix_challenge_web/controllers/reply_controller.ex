defmodule PhoenixChallengeWeb.ReplyController do
  use PhoenixChallengeWeb, :controller

  alias PhoenixChallenge.Forum
  alias PhoenixChallenge.Forum.Reply

  action_fallback PhoenixChallengeWeb.FallbackController

  def index(conn, %{"thread_id" => thread_id}) do
    replies = Forum.list_replies!(thread_id)
    render(conn, "index.json", replies: replies)
  end

  def create(conn, %{"reply" => reply_params, "thread_id" => thread_id}) do
    with {:ok, %Reply{} = reply} <- Forum.create_reply(reply_params, thread_id) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.thread_reply_path(conn, :show, thread_id, reply))
      |> render("show.json", reply: reply)
    end
  end

end
