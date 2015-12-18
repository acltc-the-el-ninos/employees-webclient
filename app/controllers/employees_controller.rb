class EmployeesController < ApplicationController
  def index
    employee_options_hashes = Unirest.get("http://localhost:3000/employees.json").body
    @employees = []
    employee_options_hashes.each do |employee_options_hash|
      @employees << Employee.new(employee_options_hash)
    end
  end

  def show
    employee_options_hash = Unirest.get("http://localhost:3000/employees/#{params[:id]}.json").body
    @employee = Employee.new(employee_options_hash)
  end

  def new
  end

  def create
    @employee = Unirest.post(
      "http://localhost:3000/employees.json",
      headers: { "Accept" => "application/json" }, 
      parameters: {
        first_name: params[:first_name],
        last_name: params[:last_name],
        email: params[:email]
      }
    ).body
    redirect_to "/employees/#{@employee['id']}"
  end

  def edit
    @employee = Unirest.get("http://localhost:3000/employees/#{params[:id]}.json").body
  end

  def update
    @employee = Unirest.patch(
      "http://localhost:3000/employees/#{params['id']}.json",
      headers: { "Accept" => "application/json" }, 
      parameters: {
        first_name: params[:first_name],
        last_name: params[:last_name],
        email: params[:email]
      }
    ).body
    redirect_to "/employees/#{@employee['id']}"
  end

  def destroy
    Unirest.delete("http://localhost:3000/employees/#{params['id']}.json")
    redirect_to "/employees"
  end
end
