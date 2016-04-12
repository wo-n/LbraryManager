class Member < ActiveRecord::Base
  include EmailAddressChecker

  attr_accessor :password, :password_confirmation
  attr_accessible :user_id, :name, :email, :password, :password_confirmation, :admin, :library_id
  validates :password, presence: { on: :create }, confirmation: { allow_blank: true }

  belongs_to :library

  has_many :reservations
  has_many :reserve_queues
  has_many :available_queues
  has_many :lend_queues

  validates :user_id, presence: { on: :create }, 
                      numericality: { only_integer: true, on: :create }
  validate :check_email
  validates :password, presence: { on: :create }, confirmation: { allow_blank: true }

  def password=(val)
    if val.present?
      self.hashed_password = BCrypt::Password.create(val)
    end
    @password = val
  end

  private
  def check_email
    if email.present?
      errors.add(:email, :invalid) unless well_formed_as_email_address(email)
    end
  end

  class << self
    def authenticate(name, password)
      member = find_by_name(name)
      if member && member.hashed_password.present? &&
         BCrypt::Password.new(member.hashed_password) == password
        member
      else
        nil
      end
    end
  end

end

