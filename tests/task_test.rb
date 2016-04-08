require_relative "test_helper"
require_relative '../app/models/task'

class TaskTest < Minitest::Test

  def setup
    @task = Task.create(task: "Do the thing", completed: false)
  end

  def teardown
    @task.destroy
  end

  def test_task_class_exists
    assert @task
  end

  def test_task_has_description
    assert_equal "Do the thing", @task.task
  end

  def task_has_a_status
    assert_equal false, @task.completed
  end
end
