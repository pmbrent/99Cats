class CatsController < ApplicationController

  before_action :not_signed_in, except: [:index, :show]
  before_action :confirm_ownership, only: [:edit, :update]

  def index
    @cats = Cat.all
  end

  def show
    @cat = Cat.find(params[:id])
  end

  def new
    @cat = Cat.new
  end

  def create
    @cat = Cat.new(cat_params)
    @cat.user_id = current_user.id
    if @cat.save
      redirect_to cat_url(@cat)
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @cat.update(cat_params)
      redirect_to cat_url(@cat)
    else
      render :edit
    end
  end

private

  def cat_params
    params.require(:cat).permit(:birth_date, :color, :name, :sex, :description)
  end

  def confirm_ownership
    @cat = current_user.cats.find(params[:id])

    rescue
      set_flash("This is not your cat.")
      redirect_to cat_url(params[:id])
  end

end
