module Controller
  class Homepage < ::Base
    get "/home" do
      erb :homepage
    end
  end
end
