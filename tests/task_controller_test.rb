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

  def test_post_new_task_redirects
    response = post "/tasks", {"name" => "Do the thing", "completed" => "false", "due_date" => "2015-04-04 00:00:00.000000"}

    assert_equal 302, response.status
    assert_equal "", response.errors
  end

end
