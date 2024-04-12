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
    @shifts = Shift.all
    @shifts.each do |shift|
      (1..shift.number_employees).each do |i|
        counter = 0
        until counter == 8
          @assignment = Assignment.new
          @assignment.shift = shift
          @assignment.employee = Employee.all.sample
          @assignment.save
        end
      end
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
