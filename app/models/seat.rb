class Seat < ApplicationRecord
  belongs_to :venue

  scope :available, -> { where(status: "AVAILABLE") }

  def available?
    self.status == "AVAILABLE"
  end

  def next_seat(seat_column_number)
    seat = self.venue.seats.find_by(name: self.row + seat_column_number.to_s)

    if seat && seat.available?
      seat.value
    else
      false
    end
    # seat ? seat.available? : false
  end

  def previous_seat_available?
    seat = self.venue.seats.find_by(name: self.row + (self.column.to_i - 1).to_s)
    seat ? seat.available? : false
  end
end
