# {
#     "venue": {
#         "layout": {
#             "rows": 10,
#             "columns": 50
#         }
#     },
#     "seats": {
#         "a1": {
#             "id": "a1",
#             "row": "a",
#             "column": 1,
#             "status": "AVAILABLE"
#         },
#         "b5": {
#             "id": "b5",
#             "row": "b",
#             "column": 5,
#             "status": "AVAILABLE"
#         },
#         "h7": {
#             "id": "h7",
#             "row": "h",
#             "column": 7,
#             "status": "AVAILABLE"
#         }
#     }
# }
require 'json'
require 'byebug'

def best_available_seat(json_parameter)
  parsed_json = JSON.parse(json_parameter)
  venue_params = parsed_json["venue"]
  seats_params = parsed_json["seats"]

  rows = venue_params["layout"]["rows"]
  columns = venue_params["layout"]["columns"]

  columns_peak = if columns % 2 == 0
    columns / 2
  else
    columns / 2 + 1
  end

  letter = "a"
  index_column = 1
  increment_index_column = true
  byebug

  oelo = (rows..1).each_with_object({}) do |row, hsh|
    (1..columns).each_with_index do |column, index|

      hsh[letter + (index + 1).to_s] = row + index_column

      if increment_index_column && index_column < columns_peak #diferenciar de columnas impar o par <= o <
        index_column += 1
      else
        increment_index_column = false
        index_column -= 1
      end
    end

    index_column = 1
    increment_index_column = true
    letter = letter.next
  end

  return oelo
end

json = '{"venue": { "layout": { "rows": 10, "columns": 50 } }, "seats": { "a1": { "id": "a1", "row": "a", "column": 1, "status": "AVAILABLE" }, "b5": { "id": "b5", "row": "b", "column": 5, "status": "AVAILABLE" }, "h7": { "id": "h7", "row": "h", "column": 7, "status": "AVAILABLE"  } } }'

p best_available_seat(json)
