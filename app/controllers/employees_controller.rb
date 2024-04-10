class EmployeesController < ApplicationController
  before_action :find_employee, only: [:show, :edit, :update, :destroy]

  def index
    @employees = Employee.all
  end

  def show
  end

  def new
    Employee.new
  end

  def create
    @employee = Employee.new(employee_params)
    if @employee.save
      redirect_to employees_path
    else
      render :new
    end
  end

  def edit

  end

  def update
    if @employee.update(employee_params)
      redirect_to employees_path
    else
      render :edit
    end
  end

  def destroy
    @employee.destroy
    redirect_to employees_path
  end

  private

  def employee_params
    params.require(:employee).permit(:name, :birthday, :email, :phone, :position)
  end

  def find_employee
    @employee = Employee.find(params[:id])
  end


end
