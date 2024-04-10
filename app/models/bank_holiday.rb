class BankHoliday < ApplicationRecord

  def self.is_bank_holiday?(date)
    BankHoliday.exists?(date: date)
  end

  def self.get_bank_holidays
    BankHoliday.all
  end

  def self.get_bank_holidays_for_year(year)
    BankHoliday.where("date >= ? AND date <= ?", Date.new(year, 1, 1), Date.new(year, 12, 31))
  end

  def self.get_bank_holidays_for_month(year, month)
    BankHoliday.where("date >= ? AND date <= ?", Date.new(year, month, 1), Date.new(year, month, -1))
  end

  def self.get_bank_holidays_for_day(year, month, day)
    BankHoliday.where(date: Date.new(year, month, day))
  end

end
