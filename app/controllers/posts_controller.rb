class PostsController < ApplicationController

  before_action :set_post, only: [:show, :edit, :update, :vote,:destroy]
  before_action :require_user, except: [:index, :show]
  before_action :authorize, only: [:edit,:update,:destroy]

  def index
    @posts = Post.all.sort_by{|x| x.total_votes}.reverse
  end

  def show
    @comment = Comment.new
  end


  def new 
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.creator = current_user
    

    if @post.save
      flash[:notice] = "Your post was created."
      redirect_to posts_path
    else
      render :new
    end

  end

  def edit


  end

  def update

    if @post.update(post_params)
      flash[:notice] = "this post was updated"
      redirect_to post_path(@post)
    else
      render :edit
    end
  end

 def destroy
    @post.destroy
    respond_to do |format|
     format.html { redirect_to root_path, notice: 'Your Post was successfully deleted.' }
     format.json { head :no_content }
   end
 end



  def vote
   @vote =  Vote.create(voteable: @post, creator: current_user, vote: params[:vote])

   respond_to do |format|
    format.html do

      if @vote.valid? 
        flash[:notice] = o'Your vote was counted.'
      else
        flash[:error] = 'You can only vote on a post once'
      end
      redirect_to :back
    end

    format.js 

  end

end


private
def authorize
  unless @post.creator == current_user
    flash[:error]= "You don't have the authorization to see that page"
    redirect_to root_path
    return false
  end
end

def post_params
  params.require(:post).permit(:title, :url, :description, category_ids: [])
end

def set_post
 @post = Post.find_by_slug(params[:id]) rescue nil
 unless @post
  redirect_to root_path
  return false
end
end

end
