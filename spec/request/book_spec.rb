require 'rails_helper'

describe 'Books API', type: :request do

    describe 'GET /books' do
        before do
            FactoryBot.create(:book, title: 'Book 1',author: 'Author 1')
            FactoryBot.create(:book, title: 'Book 2',author: 'Author 2')
            FactoryBot.create(:book, title: 'Book 3',author: 'Author 3')
        end

        it 'should return all books' do
            get '/api/v1/books'

            expect(response).to have_http_status(200)
            expect(JSON.parse(response.body).size).to eq(Book.count)
            expect(JSON.parse(response.body).size).to eq(Book.count)
        end
    end

    describe 'POST /books' do
        it 'should create a new book' do
            expect {
                post '/api/v1/books', params: { book: { title: 'Book 4', author: 'Author 4' }}
            }.to change(Book, :count).by(1)

            expect(response).to have_http_status(201)
            expect(JSON.parse(response.body)['title']).to eq('Book 4')
        end
    end

    describe 'GET /books/:id' do
        it 'should return a book' do
            book = FactoryBot.create(:book, title: 'Book 5',author: 'Author 5')

            get "/api/v1/books/#{book.id}"

            expect(response).to have_http_status(200)
            expect(JSON.parse(response.body)['title']).to eq('Book 5')
        end
    end

    describe 'DELETE /books/:id' do
        let!(:book) { FactoryBot.create(:book, title: 'Book 6',author: 'Author 6') }

        it 'should delete a book' do

            expect {
                delete "/api/v1/books/#{book.id}"
            }.to change(Book, :count).by(-1)

            expect(response).to have_http_status(204)
        end
    end

end