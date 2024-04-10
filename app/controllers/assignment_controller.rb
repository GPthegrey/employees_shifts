class AssignmentController < ApplicationController
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
    @assignment = Assignment.new(assignment_params)
    if @assignment.save
      redirect_to assignments_path
    else
      render :new
    end
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

  def assignment_params
    params.require(:assignment).permit(:start_time, :end_time, :type, :bank_holiday, :number_employees)
  end

  def find_assignment
    @assignment = Assignment.find(params[:id])
  end
end
