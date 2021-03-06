class Admin::PostsController < Admin::ApplicationController
  before_filter :find_post, :only => [:show, :edit, :update, :destroy]
  def index
    @posts = Post.all
  end
  
  def new
    @post = Post.new
  end
  
  def create
    @post = Post.new(params[:post])
    if @post.save
      flash[:success] = "Post created."
      redirect_to edit_admin_post_path(@post)
    else
      flash[:failure] = "Could not create this post."
      render :action => "new"
    end
  end
  
  def edit
    
  end
  
  def update
    if @post.update_attributes(params[:post])
      flash[:success] = "Post updated."
      redirect_to edit_admin_post_path(@post)
    else
      flash[:failure] = "Could not update this post."
      render :action => "edit"
    end
  end
  
  def destroy
    
  end
  
  private
  
    def find_post
      @post = Post.find_by_permalink!(params[:id])
    rescue ActiveRecord::RecordNotFound
      flash[:failure] = "The post you were looking for could not be found."
      redirect_to root_path
    end
    
end