# If a relationship has 'touch: true', then this will call a reload and save on the related object.
# While more exepensive an operation, it will ensure all relationships will be kept in sync.
module SavableTouch
  extend ActiveSupport::Concern

  included do
    after_touch do |item|
      item.reload.save!
    end
  end
end