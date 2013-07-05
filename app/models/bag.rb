class Bag
  include Mongoid::Document

  belongs_to :description_object
  has_one :compressed_bag

  field :title, type: String
  field :bag_content_url, type: String
end
