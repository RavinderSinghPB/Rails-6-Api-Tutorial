require 'rails_helper'

describe 'Books API', type: :request do

    describe 'GET /books' do
        before do
            author1 = FactoryBot.create(:author,first_name: 'first_name 1', last_name: 'last_name 1')
            author2 = FactoryBot.create(:author,first_name: 'first_name 2', last_name: 'last_name 2')
            author3 = FactoryBot.create(:author,first_name: 'first_name 3', last_name: 'last_name 3')

            FactoryBot.create(:book, title: 'Book 1',author_id:author1.id)
            FactoryBot.create(:book, title: 'Book 2',author_id:author2.id)
            FactoryBot.create(:book, title: 'Book 3',author_id:author3.id)           
        end

        it 'should return all books' do
            get '/api/v1/books'

            expect(response).to have_http_status(200)
            expect(JSON.parse(response.body).size).to eq(Book.count)
            expect(JSON.parse(response.body).size).to eq(3)
            expect(JSON.parse(response.body)[0]['title']).to eq('Book 1')
            expect(JSON.parse(response.body)[2]['title']).to eq('Book 3')
        end
    end

    describe 'POST /books' do
        it 'should create a new book and new author' do
            expect {
                post '/api/v1/books', params: { book: { title: 'Book 4'},
                                                author: { first_name: 'first_name 4', last_name: 'last_name 4' } }
            }.to change(Book, :count).by(1) .and change(Author, :count).by(1)
        
            
            expect(response).to have_http_status(201)
            expect(JSON.parse(response.body)['title']).to eq('Book 4')
        end
    end

    describe 'POST /books' do

        before do
            FactoryBot.create(:author,first_name: 'first_name 1', last_name: 'last_name 1')
        end

        it 'should create a new book and save to existing author' do
            expect {
                post '/api/v1/books', params: { book: { title: 'Book 4'},
                                                author: { first_name: 'first_name 1', last_name: 'last_name 1' } }
            }.to change(Book, :count).by(1) .and change(Author, :count).by(0)
        
            
            expect(response).to have_http_status(201)
            expect(JSON.parse(response.body)['title']).to eq('Book 4')
        end
    end

    describe 'GET /books/:id' do

        author = FactoryBot.create(:author,first_name: 'first_name 1', last_name: 'last_name 1')
        let!(:book) { FactoryBot.create(:book, title: 'Book 1',author_id:author.id)}

        it 'should return a book' do

            get "/api/v1/books/#{book.id}"

            expect(response).to have_http_status(200)
            expect(JSON.parse(response.body)['title']).to eq('Book 1')
        end
    end

    describe 'DELETE /books/:id' do
        author = FactoryBot.create(:author,first_name: 'first_name 1', last_name: 'last_name 1')
        let!(:book) { FactoryBot.create(:book, title: 'Book 1',author_id:author.id)}

        it 'should delete a book' do

            expect {
                delete "/api/v1/books/#{book.id}"
            }.to change(Book, :count).by(-1)

            expect(response).to have_http_status(204)
        end
    end

end