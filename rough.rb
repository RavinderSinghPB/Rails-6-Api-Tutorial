author = Author.create(first_name: "first_name 1", last_name: "last_name 1",)
book = Book.create(title: "book 2", author_id: author.id)

Book.select { |book| book.author_id.nil? }.map(&:destroy)