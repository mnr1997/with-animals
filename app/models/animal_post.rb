class AnimalPost < ApplicationRecord
  belongs_to :animal
  belongs_to :post
end
