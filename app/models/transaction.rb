class Transaction < ApplicationRecord
  belongs_to :merchant
  belongs_to :category
end
