class ExpensesController < ApplicationController
  before_action :require_login, except: [ :new, :create ]

  def index
    @expenses = Expense.order(date: :asc)
  end

  def show
    @expense = Expense.find(params[:id])
  end

  def new
    @expense = Expense.new
  end

  def create
    @expense = Expense.new(expense_params)
    if @expense.save
      redirect_to expenses_path, notice: "Expense was successfully created."
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
    params.require(:expense).permit(:category_id, :amount, :date, :description)
  end

  def require_login
    Rails.logger.debug("Session user_id: #{session[:user_id]}")
    unless session[:user_id]
      redirect_to login_path, alert: "You must be logged in to access this page."
    end
  end
end
