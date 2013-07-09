class Bag
  include Mongoid::Document

  belongs_to :description_object
  has_one :compressed_bag

  field :title, type: String
  field :bag_content_url, type: String

  # Since mongoid doesn't support :through relationships, we have to manually create them.
  def institution
    description_object.institution
  end

  def institution_id
    institution.id
  end
end
