class EmployeesController < ApplicationController
  def index
    @employees = Unirest.get("http://localhost:3000/employees.json").body
  end

  def show
    employee_options = Unirest.get("http://localhost:3000/employees/#{params[:id]}.json").body
    @employee = Employee.new(employee_options)
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
