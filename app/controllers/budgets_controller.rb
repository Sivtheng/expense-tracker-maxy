class BudgetsController < ApplicationController
  before_action :authenticate_user!
  before_action :require_login

  def edit
    @month = params[:month].to_i
    @year = params[:year].to_i
    @monthly_budget = current_user.monthly_budgets.find_or_initialize_by(month: @month, year: @year)
  end

  def update
    @month = params[:month].to_i
    @year = params[:year].to_i
    @monthly_budget = current_user.monthly_budgets.find_or_initialize_by(month: @month, year: @year)
    if @monthly_budget.update(budget_params)
      redirect_to expenses_path(month: @month, year: @year), notice: "Budget updated successfully"
    else
      render :edit
    end
  end

  def change_month
    @years = (Date.today.year - 5..Date.today.year + 5).to_a
    @months = (1..12).to_a

    @year ||= Date.today.year
    @month ||= Date.today.month
  end

  def update_month
    @year = params[:year].to_i
    @month = params[:month].to_i

    if @year > 0 && @month > 0
      redirect_to expenses_path(year: @year, month: @month)
    else
      flash[:alert] = "Invalid month or year selected"
      redirect_to change_month_path
    end
  end


  private

  def budget_params
    params.require(:monthly_budget).permit(:budget)
  end
end
