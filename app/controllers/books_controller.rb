class BooksController < ApplicationController
	before_action :authenticate_user
	before_action :ensure_correct_user,{only:[:edit, :update, :destroy]}

	def create
		  @user = current_user
		  @books = Book.all
		  @book = Book.new(book_params)
		  @book.user_id = current_user.id
          if @book.save
          	  flash[:notice] = "successfully!!"
              redirect_to book_path(@book.id)
          else
          	  flash[:alert] = "error!!"
          	  render :index
		  end
	end
	def index
		@user = current_user
		@book = Book.new
		@books = Book.all
	end

	def show
		@book_show = Book.find(params[:id])
		@book = Book.new
	end

	def edit
		@book = Book.find(params[:id])
		@user = current_user
	end

	def update
		@user = current_user
		@book = Book.find(params[:id])
		if @book.update(book_params)
		   flash[:notice] = "successfully!!"
		   redirect_to book_path(@book.id)
		else
			flash[:alert] = "error!!"
			render :edit
		end

	end

	def destroy
		@book = Book.find(params[:id])
        @book.destroy
        flash[:notice] = "successfully!!"
        redirect_to books_path
	end

	def ensure_correct_user
         @book = Book.find(params[:id])
      if @book.user_id != current_user.id
         redirect_to books_path
      end
    end

	private
	def book_params
		params.require(:book).permit(:title, :body, :user_id)
	end
end