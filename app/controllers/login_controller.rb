module Controller
  class Login < ::Base
    post "/login" do
      user = ::User.where(email: params["email"]).first_or_create

      session["user_id"] = user.id
      redirect to("/tasks")
    end
  end
end
