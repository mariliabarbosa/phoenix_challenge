defmodule PhoenixChallenge.ForumTest do
  use PhoenixChallenge.DataCase

  alias PhoenixChallenge.Forum

  describe "threads" do
    alias PhoenixChallenge.Forum.Thread

    import PhoenixChallenge.ForumFixtures

    @invalid_attrs %{author: nil, content: nil, title: nil}

    test "list_threads/0 returns all threads" do
      thread = thread_fixture()
      assert Forum.list_threads() == [thread]
    end

    test "get_thread!/1 returns the thread with given id" do
      thread = thread_fixture()
      assert Forum.get_thread!(thread.id) == thread
    end

    test "create_thread/1 with valid data creates a thread" do
      valid_attrs = %{author: "some author", content: "some content", title: "some title"}

      assert {:ok, %Thread{} = thread} = Forum.create_thread(valid_attrs)
      assert thread.author == "some author"
      assert thread.content == "some content"
      assert thread.title == "some title"
    end

    test "create_thread/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Forum.create_thread(@invalid_attrs)
    end

    test "update_thread/2 with valid data updates the thread" do
      thread = thread_fixture()
      update_attrs = %{author: "some updated author", content: "some updated content", title: "some updated title"}

      assert {:ok, %Thread{} = thread} = Forum.update_thread(thread, update_attrs)
      assert thread.author == "some updated author"
      assert thread.content == "some updated content"
      assert thread.title == "some updated title"
    end

    test "update_thread/2 with invalid data returns error changeset" do
      thread = thread_fixture()
      assert {:error, %Ecto.Changeset{}} = Forum.update_thread(thread, @invalid_attrs)
      assert thread == Forum.get_thread!(thread.id)
    end

    test "delete_thread/1 deletes the thread" do
      thread = thread_fixture()
      assert {:ok, %Thread{}} = Forum.delete_thread(thread)
      assert_raise Ecto.NoResultsError, fn -> Forum.get_thread!(thread.id) end
    end

    test "change_thread/1 returns a thread changeset" do
      thread = thread_fixture()
      assert %Ecto.Changeset{} = Forum.change_thread(thread)
    end
  end

  describe "replies" do
    alias PhoenixChallenge.Forum.Reply

    import PhoenixChallenge.ForumFixtures

    @invalid_attrs %{author: nil, content: nil}

    test "list_replies/0 returns all replies" do
      reply = reply_fixture()
      assert Forum.list_replies() == [reply]
    end

    test "get_reply!/1 returns the reply with given id" do
      reply = reply_fixture()
      assert Forum.get_reply!(reply.id) == reply
    end

    test "create_reply/1 with valid data creates a reply" do
      valid_attrs = %{author: "some author", content: "some content"}

      assert {:ok, %Reply{} = reply} = Forum.create_reply(valid_attrs)
      assert reply.author == "some author"
      assert reply.content == "some content"
    end

    test "create_reply/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Forum.create_reply(@invalid_attrs)
    end

    test "update_reply/2 with valid data updates the reply" do
      reply = reply_fixture()
      update_attrs = %{author: "some updated author", content: "some updated content"}

      assert {:ok, %Reply{} = reply} = Forum.update_reply(reply, update_attrs)
      assert reply.author == "some updated author"
      assert reply.content == "some updated content"
    end

    test "update_reply/2 with invalid data returns error changeset" do
      reply = reply_fixture()
      assert {:error, %Ecto.Changeset{}} = Forum.update_reply(reply, @invalid_attrs)
      assert reply == Forum.get_reply!(reply.id)
    end

    test "delete_reply/1 deletes the reply" do
      reply = reply_fixture()
      assert {:ok, %Reply{}} = Forum.delete_reply(reply)
      assert_raise Ecto.NoResultsError, fn -> Forum.get_reply!(reply.id) end
    end

    test "change_reply/1 returns a reply changeset" do
      reply = reply_fixture()
      assert %Ecto.Changeset{} = Forum.change_reply(reply)
    end
  end
end
