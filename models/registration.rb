class Registration < Sequel::Model
  plugin :validation_helpers

  def validate
    validates_presence :firstname
    validates_presence :lastname
    validates_presence :email
    validates_presence :street_and_no
    validates_presence :zip
    validates_presence :city
    validates_format /^.+@.+$/, :email
  end

  def full_name
    "#{firstname} #{lastname}"
  end

  def participants_string
    JSON.parse(participants_json).map{|p| "#{p[0]} #{p[1]} (#{p[2]})"}.join(', ')
  end
end
