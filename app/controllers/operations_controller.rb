class OperationsController < ApplicationController
  def index
    @category = Category.includes(:operations).find(params[:category_id])
    @category.current_user = current_user
    @operations = @category.current_user_operations.order(created_at: :desc)
  end

  def new
    @operation = Operation.new
    @category = Category.find(params[:category_id])
  end

  def create
    @operation = Operation.new(operation_params)
    @operation.author = current_user

    if @operation.save
      redirect_to category_operations_path(@operation.categories.first)
    else
      render :new
    end
  end

  private

  def operation_params
    params.require(:operation).permit(:name, :amount, category_ids: [])
  end
end
