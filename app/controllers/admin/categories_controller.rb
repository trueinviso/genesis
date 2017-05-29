class Admin::CategoriesController < Admin::BaseController

  def index
    @categories = policy_scope(Category)
    authorize @categories
  end

  def new
    authorize Category
    @category = Category.new
  end

  def create
    authorize Category
    @category = Category.new(category_params)
    if @category.save
      redirect_to admin_categories_path
    else
      render 'new'
    end
  end

  def destroy
    authorize Category
    @category = Category.find(params[:id])
    @category.destroy

    redirect_to admin_categories_path
  end

  def update
    authorize Category
    @category = Category.find(params[:id])
    if @category.update_attributes(category_params)
      redirect_to admin_categories_path
    else
      render 'edit'
    end
  end

  def edit
    authorize Category
    @category = Category.find(params[:id])
  end

  private

    def category_params
      params.require(:category).permit(:name)
    end
end
