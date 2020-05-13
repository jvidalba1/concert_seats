class VenuesController < ApplicationController

  def best_seats
    scenario = Scenario.new(rows, columns)

    if scenario.create
      render status: :ok, json: {
        status: "success",
        best_seats: scenario.best_seats(seat_params, group)
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

  def group
    venue_params["group"]
  end

  def rows
    venue_params["rows"]
  end

  def columns
    venue_params["columns"]
  end

  def venue_params
    params.require(:venue).require(:layout).permit(:rows, :columns, :group)
  end

  def seat_params
    params.require(:seats).permit!
  end
end
