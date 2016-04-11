class Student < ActiveRecord::Base
  validates :name, :email, presence: true
end
