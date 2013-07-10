class User
  include Mongoid::Document
  include Mongoid::Timestamps
  
  ROLES = %w[superuser institutional_admin institutional_user]

  belongs_to :institution, autosave: true, touch: true

  validates :institution_id, :email, :phone_number, presence: true
  validates :institution, associated: true
  validates :email, uniqueness: true

  # Custom format validations.  See lib/customer_validators.rb
  validates :name, person_name_format: true
  validates :email, email: true
  validates :phone_number, phone_format: true
  validates_inclusion_of :role, in: User::ROLES, message: "The value: %{value} is not included in #{User::ROLES.join(', ')}."

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable

  # devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable

  devise :omniauthable, :registerable, :omniauth_providers => [:google_oauth2]

  ## Database authenticatable
  field :email,              :type => String, :default => ""
  # field :encrypted_password, :type => String, :default => ""
  
  ## Recoverable
  # field :reset_password_token,   :type => String
  # field :reset_password_sent_at, :type => Time

  ## Rememberable
  field :remember_created_at, :type => Time

  ## Trackable
  field :sign_in_count,      :type => Integer, :default => 0
  field :current_sign_in_at, :type => Time
  field :last_sign_in_at,    :type => Time
  field :current_sign_in_ip, :type => String
  field :last_sign_in_ip,    :type => String

  ## Confirmable
  # field :confirmation_token,   :type => String
  # field :confirmed_at,         :type => Time
  # field :confirmation_sent_at, :type => Time
  # field :unconfirmed_email,    :type => String # Only if using reconfirmable

  ## Lockable
  # field :failed_attempts, :type => Integer, :default => 0 # Only if lock strategy is :failed_attempts
  # field :unlock_token,    :type => String # Only if unlock strategy is :email or :both
  # field :locked_at,       :type => Time

  ## Token authenticatable
  # field :authentication_token, :type => String

  # APTrust Fields
  field :name
  field :phone_number
  field :role, type: String

  def admin?
    self.role == 'admin'
  end

  # For display on views use name if available, otherwise use email.
  def display_name
    name.nil? ? email : name
  end

  def is?(role)
    self.role == role.to_s
  end
  
  def self.find_for_google_oauth2(access_token, signed_in_resource=nil)
    data = access_token.info
    user = User.where(:email => data["email"]).first

    unless user
      user = User.create(name: data["name"], email: data["email"])
    end
    user
  end
end
