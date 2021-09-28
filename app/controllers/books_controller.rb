class BooksController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :invalid_book

  def index
    render json: Book.all
  end

  def show
    render json: Book.find(params[:id])
  end

  def create
    book = Book.new(book_params)

    if book.save
      render json: book, status: :created
    else
      render json: book.errors, status: 422
    end
  end

  # TODO: Add a destroy action
  def destroy
    book = Book.find(params[:id])
    book.destroy
    
    render json: {}, status: 204
  end
    
  private

  def book_params
    params.require(:book).permit(:title, :author)
  end

  def invalid_book
    render json: { error: 'Book not found' }, status: 404
  end

end
