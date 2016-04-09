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

end
