class Employee
  attr_accessor :id, :first_name, :last_name, :email, :birthdate

  def initialize(input_options)
    @id = input_options["id"]
    @first_name = input_options["first_name"]
    @last_name = input_options["last_name"]
    @email = input_options["email"]
    @birthdate = input_options["birthdate"]
  end

  def full_name
    "#{last_name}, #{first_name}"
  end

  def self.find_by(input_options)
    id = input_options[:id]
    employee_options_hash = Unirest.get("http://localhost:3000/employees/#{id}.json").body
    Employee.new(employee_options_hash)
  end
end