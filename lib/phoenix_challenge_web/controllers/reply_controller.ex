defmodule PhoenixChallengeWeb.ReplyController do
  use PhoenixChallengeWeb, :controller

  alias PhoenixChallenge.Forum
  alias PhoenixChallenge.Forum.Reply

  action_fallback PhoenixChallengeWeb.FallbackController

  def index(conn, _params) do
    replies = Forum.list_replies()
    render(conn, "index.json", replies: replies)
  end

  def create(conn, %{"reply" => reply_params}) do
    with {:ok, %Reply{} = reply} <- Forum.create_reply(reply_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.thread_reply_path(conn, :show, reply))
      |> render("show.json", reply: reply)
    end
  end

  def show(conn, %{"id" => id}) do
    reply = Forum.get_reply!(id)
    render(conn, "show.json", reply: reply)
  end

  def update(conn, %{"id" => id, "reply" => reply_params}) do
    reply = Forum.get_reply!(id)

    with {:ok, %Reply{} = reply} <- Forum.update_reply(reply, reply_params) do
      render(conn, "show.json", reply: reply)
    end
  end

  def delete(conn, %{"id" => id}) do
    reply = Forum.get_reply!(id)

    with {:ok, %Reply{}} <- Forum.delete_reply(reply) do
      send_resp(conn, :no_content, "")
    end
  end
end
