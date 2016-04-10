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
      @task = ::Task.create!(name: params["name"], due_date: params["due_date"])
      current_user.tasks << @task
      redirect to("/tasks")
    end

    get "/tasks/:id/edit" do
      authenticate!
      @task = current_user.tasks.find(params["id"])

      erb :'tasks/update'
    end

    patch "/task/:id" do
      authenticate!
      @task = current_user.tasks.find(params["id"])
      @task.update(name: params["name"], completed: params["completed"], due_date: params["due_date"])
      redirect to("/tasks")
    end

    delete "/tasks/:id" do
      authenticate!
      @task = ::Task.find(params["id"])
      @task.destroy!
      redirect to("/tasks")
    end

    get "/tasks/next" do
      authenticate!
      incompletes = current_user.tasks.each { |task| current_user.tasks.delete(task) if task["completed"] == true }
      @random_task = incompletes.sample

      erb :'tasks/random'
    end

    get "/tasks/search" do
      authenticate!
      @tasks = ::Task.where("name LIKE ?", "%#{params[:query]}%")
      erb :'tasks/search_results'
    end
  end
end
