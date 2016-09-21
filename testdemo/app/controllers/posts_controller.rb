class PostsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]
	def index
		@posts= Post.all.order('created_at DESC')
	end

	def new
		@post= Post.new
		
	end

	def show
		@post = Post.find(params[:id])
		@comments = @post.comments
		#@comment = @post.comments.new
		@comment = Comment.new
	end

	def create
		@post = current_user.posts.build(post_params)
		if @post.save
			redirect_to root_path
		else
			render 'new'
		end
		
	end
	def edit
		@post = Post.find(params[:id])
	end

	def update
		@post = Post.find(params[:id])

		if @post.update(params[:post].permit(:title, :body))
			redirect_to @post
		else
			render 'edit'
		end
	end

	def destroy
		@post = Post.find(params[:id])
		@post.destroy

		redirect_to posts_path
	end
	

	private
	def post_params
		params.require(:post).permit(:title, :body)
	end



	

	
end