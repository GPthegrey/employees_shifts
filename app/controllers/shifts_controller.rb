class ShiftsController < ApplicationController
  before_action :find_shift, only: [:show, :edit, :update, :destroy]
  def index
    @shifts = Shift.all
  end

  def show
  end

  def new
    @shift = Shift.new
  end

  def create
    @shift = Shift.new(shift_params)
    if @shift.save
      redirect_to shifts_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @shift.update(shift_params)
      redirect_to shifts_path
    else
      render :edit
    end
  end

  def destroy
    @shift.destroy
    redirect_to shifts_path
  end

  private

  def shift_params
    params.require(:shift).permit(:start_time, :end_time, :type, :bank_holiday, :number_employees)
  end

  def find_shift
    @shift = Shift.find(params[:id])
  end
end
