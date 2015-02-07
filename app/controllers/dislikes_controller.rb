class DislikesController < ApplicationController
  before_action :set_and_authorize_dislike, only: [:show, :edit, :update, :destroy]

  after_filter :verify_authorized,  except: :index
  after_filter :verify_policy_scoped, only: :index

  def index
    @dislikes = policy_scope(Dislike.all)
    fresh_when etag: [I18n.locale, current_user, cache_key_for_all(Dislike)]
  end

  def show
    fresh_when etag: [I18n.locale, current_user, @dislike]
  end

  def new
    @dislike = Dislike.new
    authorize @dislike, :new?
  end

  def edit
  end

  def create
    @dislike = Dislike.new(dislike_params)
    authorize @dislike, :create?

    if @dislike.save
      redirect_to @dislike, notice: 'Dislike was successfully created.'
    else
      render :new
    end
  end

  def update
    if @dislike.update(dislike_params)
      redirect_to @dislike, notice: 'Dislike was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @dislike.destroy
    redirect_to dislikes_url, notice: 'Dislike was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_and_authorize_dislike
      @dislike = Dislike.find(params[:id])
      authorize @dislike, "#{action_name}?".to_sym
    end

    # Only allow a trusted parameter "white list" through.
    def dislike_params
      params.require(:dislike).permit(:dislikeable_id, :dislikeable_type, :user_id)
    end
end
