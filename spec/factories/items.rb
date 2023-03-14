# frozen_string_literal: true

FactoryBot.define do
  factory :item do
    name { 'something' }
    price  { 10 }
    rating { 4 }
    inventory
  end
end
