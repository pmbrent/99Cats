class CatRentalRequestsController < ApplicationController

  before_action :not_signed_in, except: [:index, :show]
  before_action :confirm_ownership, only: [:approve!, :deny!]

  def new
    @rental = CatRentalRequest.new
  end

  def create
    @rental = CatRentalRequest.new(rental_params)
    @rental.user_id = current_user.id
    if @rental.save
      redirect_to cat_rental_request_url(@rental)
    else
      render :new
    end
  end

  def show
    @rental = CatRentalRequest.find(params[:id])
  end

  def approve!
    @rental = CatRentalRequest.find(params[:id])
    @rental.approve!
    redirect_to cat_url(@rental.cat)
  end

  def deny!
    @rental = CatRentalRequest.find(params[:id])
    @rental.deny!
    redirect_to cat_url(@rental.cat)
  end

private

  def rental_params
    params.require(:cat_rental_request).permit(:cat_id, :start_date, :end_date)
  end

  def confirm_ownership
    current_user.cats.find(params[:cat_id])

    rescue
      set_flash("This is not your cat.")
      redirect_to cat_url(params[:cat_id])
  end

end
