require_relative "test_helper"

class TaskControllerTest < Minitest::Test
  include Rack::Test::Methods

  def app
    Server
  end

  def test_get_tasks
    response = get "/tasks"

    assert response.ok?
    assert response.body.include?("<!DOCTYPE html>")
  end

  def test_new_task_reveals_form
    response = get "tasks/new"

    assert response.ok?
    assert_equal true, response.body.include?("form action")
  end

  def test_post_new_task
    response = post "/tasks", :name => "Create a new task"

    task = Task.where(name: "Create a new task").first
    assert_equal true, task.valid?
    assert response.redirect?
  end

  def test_task_update_reveals_form
    response = get "tasks/update"

    assert response.ok?
    assert_equal true, response.body.include?("form action")
  end

  def test_patch_task
    response = post "/tasks", :name => "Before the update"
    task = Task.where(name: "Before the update").first
    task_id = task.id

    response = patch "/task/#{task_id}", :name => "After the update"
    task = Task.where(name: "After the update").first

    assert_equal "After the update", task.name
    assert response.redirect?
  end

  def test_delete_task
    response = post "/tasks", :name => "Delete me"
    task = Task.where(name: "Delete me").first
    task_id = task.id
    response = delete "/tasks/#{task_id}"

    assert_equal nil, Task.find_by(name: "Delete me")
    assert response.redirect?
  end

  def test_search_for_tasks
    response = post "/tasks", :name => "Buy a pizza"
    response = post "/tasks", :name => "Eat a pizza"
    response = post "/tasks", :name => "Learn how to cook broccoli"

    response = get "/tasks/search?query=pizza"

    assert_equal false, response.body.include?("broccoli")
  end
end
