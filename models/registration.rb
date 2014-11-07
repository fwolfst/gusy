class Registration < Sequel::Model
  plugin :validation_helpers

  def validate
    validates_presence :firstname
    validates_presence :lastname
    validates_presence :email
    validates_presence :street_and_no
    validates_presence :zip
    validates_presence :city
  end

  def full_name
    "#{firstname} #{lastname}"
  end
end
