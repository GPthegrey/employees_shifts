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
    raise
    @assignment = Assignment.new(employee_id: params[:employee_id], shift_id: params[:shift_id])
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

  def find_assignment
    @assignment = Assignment.find(params[:id])
  end
end
