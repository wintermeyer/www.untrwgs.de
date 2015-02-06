class UsersController < ApplicationController
  before_action :set_and_authorize_user, only: [:show, :edit, :update, :destroy]

  after_filter :verify_authorized,  except: :index
  after_filter :verify_policy_scoped, only: :index

  def index
    @users = policy_scope(User.all)
    fresh_when etag: [I18n.locale, current_user, cache_key_for_all(User)]
  end

  def show
    fresh_when etag: [I18n.locale, current_user, @user]
  end

  def new
    @user = User.new
    authorize @user, :new?
  end

  def edit
  end

  def create
    @user = User.new(user_params)
    authorize @user, :create?

    if @user.save
      session[:user_id] = @user.id
      redirect_to @user, notice: "Ein neuer Account wurde für Sie angelegt. Sie sind jetzt als '#{@user}' eingeloggt."
    else
      render :new
    end
  end

  def update
    if @user.update(user_params)
      redirect_to @user, notice: 'User was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @user.destroy
    redirect_to users_url, notice: 'User was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_and_authorize_user
      @user = User.find(params[:id])
      authorize @user, "#{action_name}?".to_sym
    end

    # Only allow a trusted parameter "white list" through.
    def user_params
      params.require(:user).permit(:first_name, :last_name, :gender_id, :email, :password, :password_confirmation)
    end
end
