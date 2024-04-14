class ShiftsController < ApplicationController
  before_action :find_shift, only: [:edit, :update, :destroy]
  def index
    @selected_date = params[:date] ? Date.parse(params[:date]) : Date.current
    @shifts = Shift.where(start_time: @selected_date.beginning_of_month..@selected_date.end_of_month)
    @assingments = Assignment.where(date: @selected_date)
    @assingment = Assignment.new
    @bank_holidays = BankHoliday.all
    @month = @selected_date.strftime('%m-%Y')
    @days = (@selected_date.beginning_of_month..@selected_date.end_of_month)
  end

  def shifts_per_day
    begin
      @assignment = Assignment.new
      @selected_date = Date.parse(params[:date])
      @shifts = Shift.where(start_time: @selected_date.beginning_of_day..@selected_date.end_of_day)
      @morning_shifts = @shifts.where("EXTRACT(HOUR FROM start_time) >= 7 AND EXTRACT(HOUR FROM start_time) < 15")
      @afternoon_shifts = @shifts.where("EXTRACT(HOUR FROM start_time) >= 15 AND EXTRACT(HOUR FROM start_time) < 23")
      @night_shifts = Shift.where(start_time: (@selected_date - 1).beginning_of_day..@selected_date.beginning_of_day)
      .where("EXTRACT(HOUR FROM start_time) >= 23 OR EXTRACT(HOUR FROM start_time) < 7")

    rescue ArgumentError => e
      flash[:error] = "Invalid date format"
      redirect_to root_path
    end
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
