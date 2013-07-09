class DescriptionObject
  include Mongoid::Document
  include Mongoid::Timestamps

  belongs_to :institution
  has_one :bag
  has_one :transactional_object

  field :title, type: String
  field :dpn_status, type: Boolean

  validates :institution_id, :title, :dpn_status, presence: true
  validates :institution, associated: true
end
