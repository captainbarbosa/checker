module Controller
  class Task < ::Base
    helpers do
      def current_user
        User.find_by(session["user_id"])
      end

      def authenticate!
        halt 401, "User login invalid" unless current_user
      end
    end

    get "/tasks" do
      authenticate!
      @user = current_user

      erb :'tasks/index'
    end

    get "/tasks/new" do
      authenticate!
      @user = current_user

      erb :'tasks/new'
    end

    post "/tasks" do
      authenticate!
      @task = ::Task.create!(name: params["name"], completed: false, due_date: params["due_date"])
      current_user.tasks << @task
      redirect to("/tasks")
    end
  end
end
