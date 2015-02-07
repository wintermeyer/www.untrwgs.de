class PostsController < ApplicationController
  before_action :set_and_authorize_post, only: [:show, :edit, :update, :destroy]

  after_filter :verify_authorized,  except: :index
  after_filter :verify_policy_scoped, only: :index

  def index
    @posts = policy_scope(Post.all)
    fresh_when etag: [I18n.locale, current_user, cache_key_for_all(Post)]
  end

  def show
    fresh_when etag: [I18n.locale, current_user, @post]
  end

  def new
    @post = Post.new
    authorize @post, :new?
  end

  def edit
  end

  def create
    @post = Post.new(post_params)
    authorize @post, :create?

    if @post.save
      redirect_to @post, notice: 'Post was successfully created.'
    else
      render :new
    end
  end

  def update
    if @post.update(post_params)
      redirect_to @post, notice: 'Post was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @post.destroy
    redirect_to posts_url, notice: 'Post was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_and_authorize_post
      @post = Post.find(params[:id])
      authorize @post, "#{action_name}?".to_sym
    end

    # Only allow a trusted parameter "white list" through.
    def post_params
      params.require(:post).permit(:user_id, :title, :abstract, :content, :state, :likes_count, :dislikes_count)
    end
end
