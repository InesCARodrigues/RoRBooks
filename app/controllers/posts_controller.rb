class PostsController < ApplicationController


before_action :find_post, only: [:show, :edit, :update, :destroy]
#show/edit/update/destroy are the ACTIONS that require my find_post method
#because they require me to find the post id
#"posts/:id format -> for more information see the routes :)"

def home

	@posts = Post.all.order("created_at DESC")

end

def new
	@post = Post.new
end


def show 
end

def create
	@post = Post.new(post_params())

	if @post.save # This is a commit
		redirect_to root_path
		flash[:success] = "O seu anuncio foi criado com sucesso!"
	else
		render 'new'
	end

end


def edit
end

def update
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
		params.require(:post).permit(:title, :description, :autor)
	end

	def find_post()
		# This function will search for a specific
		# post and show it to the user
		@post = Post.find(params[:id])
	end


end
