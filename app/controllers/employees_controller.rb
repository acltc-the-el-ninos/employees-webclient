class EmployeesController < ApplicationController
  def index
    @employees = Employee.all
  end

  def show
    @employee = Employee.find_by(id: params[:id])
  end

  def new
  end

  def create
    @employee = Employee.create(
      first_name: params[:first_name],
      last_name: params[:last_name],
      email: params[:email]
    )
    redirect_to "/employees/#{@employee.id}"
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
    @employee = Employee.find_by(id: params[:id])
    @employee.destroy
    redirect_to "/employees"
  end
end
