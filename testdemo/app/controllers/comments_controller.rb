class CommentsController < ApplicationController
	before_action :logged_in?, only: [:create, :destroy]
	
	def create
		#binding.pry
		@post = Post.find_by id: params[:post_id]
		@comment= Comment.new(comment_params)
		@comment.save
		
		redirect_to :back
	end

	

	def edit
		@comment = Comment.find(params[:id])
	end

	def update
		@comment = Comment.find_by(id: params[:id])
		@comment.body = params[:comment][:body]
		@comment.save
		redirect_to 'posts#show'

		
	end


	def new
		@post = Post.find(params[:post_id])
		@comment = @post.comments.new(:parent_id => params[:parent_id])
	end

	def index
		@post = Post.find(params[:post_id])
		@comments = @post.comments.arrange(:order => :created_at)
	end

	def destroy
		@comment = Comment.find(params[:id])
		@comment.destroy

		redirect_to :back
	end
	
	private
	def comment_params
		params.require(:comment).permit(:body, :user_id, :post_id)
	end

end
