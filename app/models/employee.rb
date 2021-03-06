class Employee
  attr_accessor :id, :first_name, :last_name, :email, :birthdate
  @@headers = {
    "Accept" => "application/json",
    "Authorization" => "Token token=#{ENV['API_KEY']}",
    "X-User-Email" => "#{ENV['API_EMAIL']}"
  }

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

  def destroy
    Unirest.delete(
      "#{ENV['API_BASE_URL']}/employees/#{id}.json",
      headers: @@headers
    )
  end

  def self.all
    employee_options_hashes = Unirest.get(
      "#{ENV['API_BASE_URL']}/employees.json",
      headers: @@headers
    ).body
    employees = []
    employee_options_hashes.each do |employee_options_hash|
      employees << Employee.new(employee_options_hash)
    end
    employees
  end

  def self.find_by(input_options)
    id = input_options[:id]
    employee_options_hash = Unirest.get(
      "#{ENV['API_BASE_URL']}/employees/#{id}.json",
      headers: @@headers
    ).body
    Employee.new(employee_options_hash)
  end

  def self.create(input_options)
    employee_options_hash = Unirest.post(
      "#{ENV['API_BASE_URL']}/employees.json",
      headers: @@headers, 
      parameters: input_options
    ).body
    Employee.new(employee_options_hash)
  end
end