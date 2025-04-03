class User < ApplicationRecord

  acts_as_voter

  acts_as_favoritable
  acts_as_favoritor
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  belongs_to :role , optional: true

  scope :teachers_for_event, ->(event_id) { includes(:role).where(current_event_id: event_id, roles: { name: "Teacher" , active: true }) }

  before_create :check_authentication_token

  has_one_attached :image

  attribute :remove_image, :boolean
  after_save -> { image.purge }, if: :remove_image

  has_many :courses, foreign_key: :teacher_id, dependent: :nullify
  has_many :tickets
  has_many :blogs , dependent: :delete_all


  def name
    (self.first_name || '') + ' ' + (self.last_name || '')
  end

  def check_authentication_token
    self.authentication_token = generate_unique_token if authentication_token.blank?
  end
  
  def generate_unique_token
    loop do
      token = Devise.friendly_token
      break token unless User.exists?(authentication_token: token)
    end
  end

  def superadmin?
    if role.try(:name) == 'SuperAdmin'
      return true 
    end
    false
  end

  def admin?
    if role.try(:name) == 'Admin'
      return true 
    end
    false
  end

  def teacher?
    if role.try(:name) == 'Teacher'
      return true 
    end
    false
  end

  def normal?
    if role.try(:name) == 'Normal'
      return true 
    end
    false
  end

end
