class Tarea < ActiveRecord::Base
  validates :titulo, presence: true
end
