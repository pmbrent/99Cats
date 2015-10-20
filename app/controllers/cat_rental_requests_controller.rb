class CatRentalRequestsController < ApplicationController

  def new
    @rental = CatRentalRequest.new
  end

  def create
    @rental = CatRentalRequest.new(rental_params)

    if @rental.save
      redirect_to cat_rental_request_url(@rental)
    else
      render :new
    end
  end

  def show
    @rental = CatRentalRequest.find(params[:id])
  end

private

  def rental_params
    params.require(:cat_rental_request).permit(:cat_id, :start_date, :end_date)
  end

end
