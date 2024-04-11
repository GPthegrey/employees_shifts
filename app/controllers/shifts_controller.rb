class ShiftsController < ApplicationController
  before_action :find_shift, only: [:edit, :update, :destroy]
  def index
    @selected_date = params[:date] ? Date.parse(params[:date]) : Date.current
    @shifts = Shift.where(start_time: @selected_date.beginning_of_month..@selected_date.end_of_month)
    @assingments = Assignment.where(date: @selected_date)
    @bank_holidays = BankHoliday.all
    @month = @selected_date.strftime('%Y-%m')
    @days = (@selected_date.beginning_of_month..@selected_date.end_of_month).map(&:day)
  end

  def shifts_per_day
    @selected_date = Date.parse(params[:date])
    @shifts = Shift.where("DATE(start_time) = ?", @selected_date)
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
