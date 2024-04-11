class BankHolidayController < ApplicationController
  def create
    @bank_holiday = BankHoliday.new(bank_holiday_params)
    if @bank_holiday.save
      redirect_to shifts_path
    else
      render 'shifts/index'
    end
  end

  private

  def bank_holiday_params
    params.require(:bank_holiday).permit(:date, :name)
  end
end
