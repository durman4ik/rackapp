class UsersController < Lobster::BaseController
  def index
    @users = User.all

    render 'users/index'
  end

  def new
    render 'users/new'
  end

  def edit
    set_user

    render 'users/edit'
  end

  def update
    set_user

    @user.update(params)
    @user.save

    redirect 'users/index'
  end

  def create
    user = User.new(params)
    user.save

    redirect 'users/index'
  end

  def destroy
    set_user

    @user.destroy

    redirect 'users/index'
  end

  private

  def set_user
    @user = User.find(params[:id])
  end
end
