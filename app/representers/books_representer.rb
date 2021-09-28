class BooksRepresenter
 
    def initialize(books)
        @books = books
    end
     
    def as_json
        @books.map do |book|
        {
            :id => book.id,
            :title => book.title,
            :author_name => author_name(book), 
            :created_at => book.created_at,
            :updated_at => book.updated_at
        }
        end.to_json
    end

    private

    attr_reader :books

    def author_name(book)
        "#{book.author.first_name} #{book.author.last_name}"
    end
     
end