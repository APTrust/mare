class Institution
  include Mongoid::Document

  has_many :description_objects
  has_many :users

  field :api_key, type: String
  field :name, type: String
  field :point_of_contact, type: String

  validates :name, presence: true

  def to_xml(options = {})
    require 'builder'
    options[:indent] ||= 2
    xml = options[:builder] ||= ::Builder::XmlMarkup.new(indent: options[:indent])
    xml.instruct! unless options[:skip_instruct]
    xml.institution do
      xml.tag!(:pid, pid)
      xml.tag!(:id, _id)
      xml.tag!(:name, name)
    end
  end

end
