class Album < ApplicationRecord
  has_one_attached :image
  has_many_attached :photos
  belongs_to :user

  has_and_belongs_to_many :tags, dependent: :destroy

  def tagged=(names)
    self.tags = names.split(',').map do |name|
      Tag.where(tags: name.strip).first_or_create!
    end
  end

  def tagged
    tags.map(&:tags).join(", ")
  end
  
  validates :title, presence: true, length: {minimum:3}
  validates :description, presence: true, length: {minimum:10}

  private
    def confirmation_email
      ApplicationMailer.welcome_email(user).deliver_now
    end
end
