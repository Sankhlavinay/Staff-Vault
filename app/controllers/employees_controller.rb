# frozen_string_literal: true

class EmployeesController < ApplicationController
  before_action :set_employee, only: %i[edit update show destroy]

  def index
    @q = Employee.ransack(params[:q])
    @employees = @q.result(distinct: true)
  end

  def new
    @employee = Employee.new
  end

  def create
    @employee = Employee.new(employee_params)
    if @employee.save
      redirect_to employees_path, notice: 'Employee has been created successfull'
    else
      render :new
    end
  end

  def edit; end

  def update
    if @employee.update(employee_params)
      redirect_to employees_path, notice: 'Employee has been updated successfully'
    else
      render :edit
    end
  end

  def show; end

  def destroy
    return unless @employee.destroy

    redirect_to employees_path, notice: 'Employee has been deleted successfully'
  end

  private

  def employee_params
    params.require(:employee).permit(:first_name, :middle_name, :last_name, :personal_email, :city, :state, :country,
                                     :pincode, :address_line_1, :address_line_2, :date_of_birth, :date_of_joining,
                                     :job_title, :bio)
  end

  def set_employee
    @employee = Employee.find(params[:id])
  rescue ActiveRecord::RecordNotFound => e
    redirect_to employees_path, notice: e
  end
end
