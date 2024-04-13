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
    start_date = Date.new(2024, 4, 13)
    end_date = Date.new(2024, 4, 30)

    while start_date <= end_date
      # Shifts
      @shifts = Shift.where("start_time <= ? AND end_time >= ?", start_date.end_of_day, start_date.beginning_of_day)

      # Fetch morning, afternoon, and night shifts
      @shifts_morning = @shifts.where("EXTRACT(HOUR FROM start_time) >= 7 AND EXTRACT(HOUR FROM start_time) < 15")
      @shifts_afternoon = @shifts.where("EXTRACT(HOUR FROM start_time) >= 15 AND EXTRACT(HOUR FROM start_time) < 23")
      @shifts_night = @shifts.where("EXTRACT(HOUR FROM start_time) >= 23 OR EXTRACT(HOUR FROM start_time) < 7")

      # Employees
      employees_needed = @shifts_morning.first.number_employees * 2
      @employees_total = Employee.all.limit(employees_needed)

      # Fetch morning employees
      @employees_morning = @employees_total.limit(@shifts_morning.first.number_employees)

      # Fetch afternoon employees
      remaining_employees_needed = employees_needed - @shifts_morning.first.number_employees
      @employees_afternoon = @employees_total.where.not(id: @employees_morning.pluck(:id)).limit(remaining_employees_needed)

      # Fetch night shift employees
      @employees_night = Employee.where(position: 'playero').where.not(id: @employees_morning.pluck(:id) + @employees_afternoon.pluck(:id)).limit(@shifts_night.first.number_employees)

      # Assign morning employees
      assign_employees_to_shifts(@shifts_morning, @employees_morning)

      # Assign afternoon employees
      assign_employees_to_shifts(@shifts_afternoon, @employees_afternoon)

      # Assign night shift employees
      assign_employees_to_shifts(@shifts_night, @employees_night)

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

  def assign_employees_to_shifts(shifts, employees)
    assign_employees = employees
    shifts.each do |shift|
      shift.number_employees.times do
        assign_employee = assign_employees.first
        if assign_employee
          @assignment = Assignment.new(shift: shift, employee: assign_employee)
          if @assignment.save
            assign_employees = assign_employees.reject { |employee| employee == assign_employee }
          else
            puts 'Error creating assignment'
          end
        else
          puts 'No hay empleados disponibles. Asignar empleado de forma manual'
          break
        end
      end
    end
  end
end
