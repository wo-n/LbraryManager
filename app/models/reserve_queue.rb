class ReserveQueue < ActiveRecord::Base
  attr_accessible :reservation_id, :member_id, :library_id, :book_id, :reserve_date
  belongs_to :resevation
  belongs_to :member
  belongs_to :library
  belongs_to :book
end
