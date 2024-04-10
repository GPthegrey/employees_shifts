# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# Create a new bank holiday object for each bank holiday in the year

#destroy all records
puts 'destroying all records'
BankHoliday.destroy_all
Shift.destroy_all

puts 'creating bank holidays'
BankHoliday.create(date: Date.new(2024, 5, 1), name: 'dia del trabajador')
BankHoliday.create(date: Date.new(2024, 5, 25), name: 'primer gobierno patrio')
BankHoliday.create(date: Date.new(2024, 6, 17), name: 'paso a la inmortalidad del general martin miguel de guemes')
BankHoliday.create(date: Date.new(2024, 6, 20), name: 'dia de la bandera')
BankHoliday.create(date: Date.new(2024, 7, 9), name: 'dia de la independencia')
BankHoliday.create(date: Date.new(2024, 8, 19), name: 'paso a la inmortalidad del general jose de san martin')
BankHoliday.create(date: Date.new(2024, 10, 14), name: 'dia del respeto a la diversidad cultural')
BankHoliday.create(date: Date.new(2024, 11, 20), name: 'dia de la inmaculada concepcion de maria')
BankHoliday.create(date: Date.new(2024, 12, 24), name: 'noche buena')
BankHoliday.create(date: Date.new(2024, 12, 25), name: 'navidad')

# Define the start and end date for the year
start_date = Date.new(2024, 5, 1)
end_date = Date.new(2024, 12, 31)

# Iterate through each hour of the year
  (start_date..end_date).each do |date|
    (0..23).each do |hour|
      start_time = DateTime.new(date.year, date.month, date.day, hour, 0, 0)
      end_time = start_time + 1.hour

      # Create a new shift object for each hour
      puts 'creating shift'
      Shift.create(
        start_time: start_time,
        end_time: end_time,
        turno:
        if start_time.hour >= 7 && start_time.hour < 15
          'mañana'
        elsif start_time.hour >= 15 && start_time.hour < 23
          'tarde'
        else
          'noche'
        end,
        day_of_week: start_time.strftime('%A'),
        bank_holiday:
        if BankHoliday.exists?(date: start_time.to_date) || day_of_week == 'Sunday'
          return true
        end
        )
    end
end
