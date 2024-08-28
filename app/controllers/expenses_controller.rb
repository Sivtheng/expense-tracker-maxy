# app/controllers/expenses_controller.rb
class ExpensesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user
  before_action :require_login, except: [ :index, :show ]
  before_action :find_expense, only: [ :show, :edit, :update, :confirm_delete, :destroy ]

  def index
    @year = params[:year].to_i
    @month = params[:month].to_i
    @year = Date.today.year if @year.zero?
    @month = Date.today.month if @month.zero?

    # Format month to always have two digits
    formatted_month = @month.to_s.rjust(2, "0")

    # Use strftime for SQLite-compatible date extraction
    @expenses = current_user.expenses.where("strftime('%Y', date) = ? AND strftime('%m', date) = ?", @year.to_s, formatted_month)
    @monthly_budget = current_user.monthly_budgets.find_or_initialize_by(month: @month, year: @year)
    @total_spent = @expenses.sum(:amount) || 0
  end

  def show
    @expense = Expense.find(params[:id])
  end

  def new
    @expense = Expense.new
  end

  def create
    @expense = @user.expenses.build(expense_params)
    if @expense.save
      redirect_to expenses_path(month: @expense.date.month), notice: "Expense was successfully created."
    else
      render :new
    end
  end

  def edit
    @expense = Expense.find(params[:id])
  end

  def update
    @expense = Expense.find(params[:id])
    if @expense.update(expense_params)
      redirect_to expenses_path, notice: "Expense was successfully updated."
    else
      render :edit
    end
  end

  def confirm_delete
    @expense = Expense.find(params[:id])
  end

  def destroy
    @expense = Expense.find(params[:id])
    @expense.destroy
    redirect_to expenses_path, notice: "Expense was successfully destroyed."
  end

  private

  def expense_params
    params.require(:expense).permit(:description, :amount, :date, :category_id)
  end

  def require_login
    Rails.logger.debug("Session user_id: #{session[:user_id]}")
    unless session[:user_id]
      redirect_to login_path, alert: "You must be logged in to access this page."
    end
  end

  def set_user
    @user = current_user
    # Handle the case where @user is nil
    redirect_to login_path, alert: "You must be logged in to access this page." unless @user
  end

  def find_expense
    @expense = Expense.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to expenses_path, alert: "Expense not found."
  end
end
