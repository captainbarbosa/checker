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

  def test_get_new_task_reveals_form
    response = get "tasks/new"

    assert response.ok?
    assert_equal true, response.body.include?("form action")
  end

  def test_post_new_task_creates_task
    response = post "/tasks", :name => "Create a new task"

    task = Task.where(name: "Create a new task").first
    assert_equal true, task.valid?
  end

end
