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

end
