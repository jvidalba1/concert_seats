class VenuesController < ApplicationController

  # Best available seats
  def best_seats
    scenario = Scenario.new(rows, columns)

    if scenario.create
      render status: :ok, json: {
        best_seat: scenario.best_seat(seat_params)
      }
    else
      render status: :unprocessable_entity, json: {
        error: {
          message: "Could not create the scenario"
        }
      }
    end
  end

  private

  def rows
    venue_params["rows"]
  end

  def columns
    venue_params["columns"]
  end

  def venue_params
    params.require(:venue).require(:layout).permit(:rows, :columns)
  end

  def seat_params
    params.require(:seats).permit!
  end
end
