class Event < ApplicationRecord
    searchkick language: "japanese"
    attr_accessor :remove_image

    before_save :remove_image_if_user_accept
    has_one_attached :image
    belongs_to :owner, class_name: "User"
    has_many :tickets, dependent: :destroy

    validates :name, length: {maximum: 50}, presence: true 
    validates :place, length: {maximum: 100}, presence: true
    validates :content, length: {maximum: 2000}, presence: true
    validates :image, 
      content_type: [:png, :jpg, :jpeg],
      size: {less_than_or_equal_to: 10.megabytes},
      dimension: {width: {max: 2000}, height: {max: 2000}}
    validate :start_at_should_be_before_end_at

    def created_by?(user)
        return false unless user
        owner_id == user.id
    end

    private 

    def start_at_should_be_before_end_at
        return unless  start_at && end_at
            
        if start_at >= end_at 
            errors.add(:start_dt, "is before end_at")
        end
    end 

    def remove_image_if_user_accept
        self.image = nil if ActiveRecord::Type::Boolean.new.cast(remove_image)
    end

    def search_data
        {
            name: name,
            place: place,
            content: content,
            owner_name: owner&.name,
            start_at: start_at
        }
    end
end
