require_relative "test_helper"

class LoginControllerTest < Minitest::Test
  include Rack::Test::Methods

  def app
    Server
  end

  def test_login_route
    response = post "/login", {"email" => "bob@email.com"}
    
    assert response.redirect?
  end

end
