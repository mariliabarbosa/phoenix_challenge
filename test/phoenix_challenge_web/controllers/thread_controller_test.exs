defmodule PhoenixChallengeWeb.ThreadControllerTest do
  use PhoenixChallengeWeb.ConnCase

  import PhoenixChallenge.ForumFixtures

  alias PhoenixChallenge.Forum.Thread

  @create_attrs %{
    author: "some author",
    content: "some content",
    title: "some title"
  }
  @update_attrs %{
    author: "some updated author",
    content: "some updated content",
    title: "some updated title"
  }
  @invalid_attrs %{author: nil, content: nil, title: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all threads", %{conn: conn} do
      conn = get(conn, Routes.thread_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create thread" do
    test "renders thread when data is valid", %{conn: conn} do
      conn = post(conn, Routes.thread_path(conn, :create), thread: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.thread_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "author" => "some author",
               "content" => "some content",
               "title" => "some title"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.thread_path(conn, :create), thread: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update thread" do
    setup [:create_thread]

    test "renders thread when data is valid", %{conn: conn, thread: %Thread{id: id} = thread} do
      conn = put(conn, Routes.thread_path(conn, :update, thread), thread: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.thread_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "author" => "some updated author",
               "content" => "some updated content",
               "title" => "some updated title"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, thread: thread} do
      conn = put(conn, Routes.thread_path(conn, :update, thread), thread: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete thread" do
    setup [:create_thread]

    test "deletes chosen thread", %{conn: conn, thread: thread} do
      conn = delete(conn, Routes.thread_path(conn, :delete, thread))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.thread_path(conn, :show, thread))
      end
    end
  end

  defp create_thread(_) do
    thread = thread_fixture()
    %{thread: thread}
  end
end
