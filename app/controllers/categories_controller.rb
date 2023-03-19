class CategoriesController < ApplicationController
  def index
    @categories = Category.all
  end

  def show
    @category = Category.find(params[:id])
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)

    icon = params[:category][:icon]
    if icon
      File.binwrite(Rails.root.join('app/assets/images', 'uploads', icon.original_filename), icon.read)
      @category.icon_url = icon.original_filename
    end

    if @category.save
      redirect_to categories_path
    else
      render :new
    end
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end
end
