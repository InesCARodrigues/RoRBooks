class PostsController < ApplicationController


before_action :find_post, only: [:show, :edit, :update, :destroy]
#show/edit/update/destroy are the ACTIONS that require my find_post method
#because they require me to find the post id
#"posts/:id format -> for more information see the routes :)"


def index

	if params[:category].blank?
		@posts = Post.all.order("created_at DESC")
	else
		@category_id = Category.find_by(name: params[:category]).id
		@posts = Post.where(:category_id => @category_id).order("created_at DESC")
	end

end

def new
	@post = current_user.posts.build
	@categories = Category.all.map { |c| [c.name, c.id]}
end


def show 
	if @post.reviews.blank?
		@averageReview = 0
	else
		@averageReview = @post.reviews.average(:rating).round(2)
	end
end

def create
	@post = current_user.posts.build(post_params())
	@post.category_id = params[:category_id]

	if @post.save # This is a commit
		
		flash[:success] = "O seu anuncio foi criado com sucesso!"
		redirect_to root_path
	else
		render 'new'
	end

end


def edit
	@categories = Category.all.map { |c| [c.name, c.id]}
	
end

def update
	@post.category_id = params[:category_id]
	if @post.update(post_params())
		redirect_to post_path(@post)
	else
		render 'edit'
	end
end

def destroy
	@post.destroy
	redirect_to root_path
end

private
	def post_params()
		params.require(:post).permit(:title, :description, :autor, :category_id, :post_image)
	end

	def find_post()
		# This function will search for a specific
		# post and show it to the user
		@post = Post.find(params[:id])
	end


end
