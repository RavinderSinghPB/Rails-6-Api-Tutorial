class Book < ApplicationRecord

    validates :title, presence: true, length: { minimum: 3, maximum: 50 }
    validates :author, presence: true, length: { minimum: 3, maximum: 50 }

end
