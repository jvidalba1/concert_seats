class Scenario

  def initialize(rows, columns)
    @rows = rows
    @columns = columns
    @columns_peak = columns_peak
    @venue = venue
  end

  def best_seat(seats_params)
    seat_names = seats_params.keys

    seat_values = seat_names.each_with_object(Hash.new(0)) do |seat_name, hsh|
      seat = @venue.seats.find_by(name: seat_name)
      hsh[seat_name] = seat ? seat.value : 0
    end
    seat_values.key(seat_values.values.max)
  end

  def columns_peak
    @even = false
    if @columns % 2 == 0
      @even = true
      @columns / 2
    else
      @columns / 2 + 1
    end
  end

  def venue
    @venue ||= Venue.new(rows: @rows, columns: @columns, name: "Concert")
  end

  def assign_seats(letter, c_index, row, index_column)
    venue.seats << Seat.new(name: letter + c_index, row: letter, column: c_index, status: "AVAILABLE", value: row + index_column)
  end

  def create

    letter = "a"
    index_column = 1
    increment_index_column = true

    (1..@rows).to_a.reverse.each do |row|
      (1..@columns).to_a.each_with_index do |column, index|
        assign_seats(letter, (index+1).to_s, row, index_column)

        if index_column < @columns_peak && increment_index_column
          index_column += 1
        elsif @even && increment_index_column && index_column == @columns_peak
          increment_index_column = false
        else
          increment_index_column = false
          index_column -= 1
        end
      end

      index_column = 1
      increment_index_column = true
      letter = letter.next
    end

    if venue.save
      true
    else
      false
    end
  end
end
