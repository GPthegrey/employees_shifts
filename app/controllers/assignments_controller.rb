class AssignmentsController < ApplicationController
  before_action :find_assignment, only: [:show, :edit, :update, :destroy]
  def index
    @assignments = Assignment.all
  end

  def show
  end

  def new
    @assignment = Assignment.new
  end

  def create
    start_date = Date.new(2024, 4, 11)
    end_date = Date.new(2024, 4, 30)
    while start_date <= end_date
      @shifts = Shift.where(start_time: start_date)
      @shifts.each do |shift|
        shift.number_employees.times do
          if shift.turno == "noche"
            @employee = Employee.where(position: "playero").sample
          else
            @employee = Employee.all.sample
          end
          @assignment = Assignment.new
          @assignment.shift = shift
          @assignment.employee = @employee
          @assignment.save
        end
      end
      start_date += 1.day
    end
    redirect_to shifts_path
  end

  def edit
  end

  def update
    if @assignment.update(assignment_params)
      redirect_to assignments_path
    else
      render :edit
    end
  end

  def destroy
    @assignment.destroy
    redirect_to assignments_path
  end

  private

  def find_assignment
    @assignment = Assignment.find(params[:id])
  end
end
