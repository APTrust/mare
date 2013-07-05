class DescriptionObject
  include Mongoid::Document

  belongs_to :institution
  has_one :bag
  has_one :transactional_object

  field :title, type: String
  field :dpn_status, type: Boolean
end
