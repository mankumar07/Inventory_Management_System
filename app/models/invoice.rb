# frozen_string_literal: true

class Invoice < ApplicationRecord
  validates :quantity, presence: true
  belongs_to :user
  belongs_to :item
end
