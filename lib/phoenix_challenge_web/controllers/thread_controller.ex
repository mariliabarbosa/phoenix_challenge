defmodule PhoenixChallengeWeb.ThreadController do
  use PhoenixChallengeWeb, :controller

  alias PhoenixChallenge.Forum
  alias PhoenixChallenge.Forum.Thread

  action_fallback PhoenixChallengeWeb.FallbackController

  def index(conn, _params) do
    threads = Forum.list_threads()
    render(conn, "index.json", threads: threads)
  end

  def create(conn, %{"thread" => thread_params}) do
    with {:ok, %Thread{} = thread} <- Forum.create_thread(thread_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.thread_path(conn, :show, thread))
      |> render("show.json", thread: thread)
    end
  end

  def show(conn, %{"id" => id}) do
    thread = Forum.get_thread!(id)
    render(conn, "show.json", thread: thread)
  end

  def update(conn, %{"id" => id, "thread" => thread_params}) do
    thread = Forum.get_thread!(id)

    with {:ok, %Thread{} = thread} <- Forum.update_thread(thread, thread_params) do
      render(conn, "show.json", thread: thread)
    end
  end

  def delete(conn, %{"id" => id}) do
    thread = Forum.get_thread!(id)

    with {:ok, %Thread{}} <- Forum.delete_thread(thread) do
      send_resp(conn, :no_content, "")
    end
  end
end
