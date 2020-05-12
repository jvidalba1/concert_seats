class VenuesController < ApplicationController

  # Best available seats
  def best_seats
    byebug
  end

  private

  def venue_params
    params.require(:venue).permit(:rows, :columns)
  end

  def seat_params
    params.require(:seats).permit(:id, :row, :column, :status)
  end
end
