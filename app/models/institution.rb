class Institution
  include Mongoid::Document

  field :api_key, type: String
  field :name, type: String
  field :point_of_contact, type: String

  validates :name, :point_of_contact, presence: true

end
