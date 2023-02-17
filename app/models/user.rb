# frozen_string_literal: true

class User < ApplicationRecord
  rolify
  has_many :invoices
  # after_create :assign_default_role
  after_initialize :set_default_role, if: :new_record?
  validates :roles, presence: true 
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # def assign_default_role
  #   self.add_role(:newuser) if self.roles.blank?
  # end

  def set_default_role
    self.add_role(:normal)
  end
end

