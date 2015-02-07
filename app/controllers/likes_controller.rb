class LikesController < ApplicationController
  before_action :set_and_authorize_like, only: [:show, :edit, :update, :destroy]

  after_filter :verify_authorized,  except: :index
  after_filter :verify_policy_scoped, only: :index

  def index
    @likes = policy_scope(Like.all)
    fresh_when etag: [I18n.locale, current_user, cache_key_for_all(Like)]
  end

  def show
    fresh_when etag: [I18n.locale, current_user, @like]
  end

  def new
    @like = Like.new
    authorize @like, :new?
  end

  def edit
  end

  def create
    @like = Like.new(like_params)
    authorize @like, :create?

    if @like.save
      redirect_to @like, notice: 'Like was successfully created.'
    else
      render :new
    end
  end

  def update
    if @like.update(like_params)
      redirect_to @like, notice: 'Like was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @like.destroy
    redirect_to likes_url, notice: 'Like was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_and_authorize_like
      @like = Like.find(params[:id])
      authorize @like, "#{action_name}?".to_sym
    end

    # Only allow a trusted parameter "white list" through.
    def like_params
      params.require(:like).permit(:likeable_id, :likeable_type, :user_id)
    end
end
