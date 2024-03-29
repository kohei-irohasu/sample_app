class UsersController < ApplicationController
  before_action :logged_in_user, only: [:edit, :update]
  
  def new
    @user = User.new
  end
  
  def show
    @user = User.find(params[:id])
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      redirect_to @user
      flash[:success] = "Welcom to the Sample App!"
    else
      render 'new'
    end
    
    def edit 
      @user = User.find(params[:id])
    end
    
    def update
      @user = User.find(params[:id])
      if @user.update(user_params)
        flash[:success] = "Profile 更新しました！"
        redirect_to @user
      else
        render 'edit'
      end
    end
  end
  
    private
  
      def user_params
        params.require(:user).permit(:name, :email, :password, :password_confirmation)
      end
      
      #beforeアクション
      
      #ログイン済みユーザーかどうか確認
      def logged_in_user
        unless logged_in?
          flash[:danger] = "Please log in."
          redirect_to login_url
        end
      end
end
