class HomeController < Lobster::BaseController
  def index
    @users = User.all

    render 'home/index'
  end
end
