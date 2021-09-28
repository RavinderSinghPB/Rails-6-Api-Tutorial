require 'rails_helper'

describe 'Books API', type: :request do
    it 'should return all books' do
        FactoryBot.create(:book, title: 'Book 1',author: 'Author 1')
        FactoryBot.create(:book, title: 'Book 2',author: 'Author 2')
        FactoryBot.create(:book, title: 'Book 3',author: 'Author 3')

        get '/api/v1/books'

        expect(response).to have_http_status(200)
        expect(JSON.parse(response.body).size).to eq(3)
    end
end