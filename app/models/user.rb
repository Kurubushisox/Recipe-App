class User < ActiveRecord::Base
  REGISTRABLE_ATTRIBUTES = %i(email  password password_confirmation name)
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :recipes, dependent: :destroy
  has_one  :post_image, as: :imageable, dependent: :destroy

  accepts_nested_attributes_for :post_image, allow_destroy: true, reject_if: proc {|attributes| attributes['image'].blank? }

  validates :name, presence: true, length: {maximum: 30}

  after_initialize {
    build_post_image unless self.persisted? || post_image.present?
  }

end
