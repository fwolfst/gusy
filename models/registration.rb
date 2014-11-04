class Registration < Sequel::Model
  plugin :validation_helpers

  def validate
    #validates_presence :city
    validates_presence :firstname
    validates_presence :lastname
    #validates_presence :email
  end

  def full_name
    "#{firstname} #{lastname}"
  end
end
