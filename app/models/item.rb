# frozen_string_literal: true

require 'csv'
class Item < ApplicationRecord
  validates :name, presence: true, uniqueness: { case_sensitive: false }
  validates :price, presence: true
  validates :rating, numericality: { less_than_equal: 5, message: 'Rating should be in between 1-5' }
  belongs_to :inventory, optional: true
  has_many :invoices

  def self.to_csv
    attributes = %w[id name price rating]

    CSV.generate(headers: true) do |csv|
      csv << attributes

      all.each do |item|
        csv << attributes.map { |attr| item.send(attr) }
      end
    end
  end
end
