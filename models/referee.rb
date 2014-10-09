class Referee < Sequel::Model
  many_to_many :seminars, :join_table => :seminars_referees

  def full_name
    "#{first_name} #{last_name}"
  end
end

class Qualification < Sequel::Model(:seminars_referees)
  many_to_one :seminar
  many_to_one :referee
end
