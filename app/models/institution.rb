class Institution
  include Mongoid::Document
  include Mongoid::Timestamps

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
      xml.pid pid
      xml.id _id
      xml.name name
      xml.users do
        self.users.each {|user|
          xml.user do
            xml.id user._id
            xml.name user.display_name
            xml.email user.email
            xml.phone_number user.phone_number
            xml.role user.role
          end
        }
      end
    end
  end
end
