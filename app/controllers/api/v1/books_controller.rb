
  module Api
    module V1

        class BooksController < ApplicationController
            rescue_from ActiveRecord::RecordNotFound, with: :invalid_book
          
            def index
              books = Book.all
              render json: BooksRepresenter.new(books).as_json
            end
          
            def show
              render json: Book.find(params[:id])
            end
          
            def create
              author = Author.find_or_create_by(author_params)
              book = Book.new(book_params.merge(author: author))
              puts book_params
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
              params.require(:book).permit(:title)
            end

            def author_params
              params.require(:author).permit(:author_id ,:first_name , :last_name)
            end
          
            def invalid_book
              render json: { error: 'Book not found' }, status: 404
            end
          
        end        

    end
  end