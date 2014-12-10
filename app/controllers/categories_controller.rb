class CategoriesController < ApplicationController 

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)


    if @category.save
      flash[:notice] = "Category has been created"
      redirect_to root_path
    else
      render :new
    end

  end


def show
  @category = Category.find_by_slug(params[:id]) rescue nil
end



private
def category_params
  params.require(:category).permit(:name)
  end


end
