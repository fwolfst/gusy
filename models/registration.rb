class Registration < Sequel::Model
  def full_name
    "#{firstname} #{lastname}"
  end
end
