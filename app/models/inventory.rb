# frozen_string_literal: true

class Inventory < ApplicationRecord
  validates :category_name, presence: true, uniqueness: { case_sensitive: false }
  has_many :items, dependent: :destroy
end
