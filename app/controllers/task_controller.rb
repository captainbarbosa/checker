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
  end
end
