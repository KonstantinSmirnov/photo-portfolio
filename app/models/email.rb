class Email
  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming

  attr_accessor :name, :email, :topic, :message

  validates :name, presence: true
  validates :email, presence: true
  validates :topic, presence: true
  validates :message, presence: true

  def initialize(attributes = {})
    attributes.each do |name, value|
      send("#{name}=", value)
    end
  end

  def send_contact_email
    ContactMailer.new_contact_email(self).deliver
  end

  def persisted?
    false
  end
end
