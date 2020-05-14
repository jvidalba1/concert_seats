
# Problem

Best Available Seat
Write a solution to return the best seat (closest to the front & middle) given a list of open seats. Rows follow alphabetical order with "a" being the first row. Columns follow numerical order from left to right.

The list of open seats, number of rows and columns (seats) is based on a JSON input.

```
{
  "venue": {
    "layout": {
      "rows": 10,
      "columns": 50
    }
  },
  "seats": {
    "a1": {
      "id": "a1",
      "row": "a",
      "column": 1,
      "status": "AVAILABLE"
    },
    "b5": {
      "id": "b5",
      "row": "b",
      "column": 5,
      "status": "AVAILABLE"
    },
    "h7": {
      "id": "h7",
      "row": "h",
      "column": 7,
      "status": "AVAILABLE"
    }
  }
}
```

The solution should find the best open seat (closest to the front & middle) given the input JSON and number of requested seats. Imagine a concert, people want to be as close as possible to the stage.

For example, for a venue with 10 rows and 12 columns with all seats open, the best seat would be A6.

If a group of seats is requested, the algorithm needs to find the best open group of seats together. In the example above, for 3 seats, it would be A5, A6, and A7.

For 5 columns and 2 requested seats the best open seats - assuming the first row A is fully occupied and the second row B is fully open, would be B2 and B3.

- Start by a single seat request (not a group of seats together)
- The app should have automated tests
- The app needs a README.md explaining the app and steps to run it locally
- Script or Rails app (see Bonus) for manual testing the implementation

Bonus:
Rails app for testing out the solution
React for the interface


# README

## Implementation

Simulate a grid, each position has a name which is built by the row (letter) and column (number), for example, "a1" for the first position.
Also, a value is given for each position of the grid depending on its rows and column.

Column value calculation: The number of columns is divided by 2, if the column number is even two peak numbers are found, otherwise, only one peak is found.

For example:
For 6 columns: 6 / 2 = 3 ... 3 will be the peak, but as 6 is even, there will be two peaks: [1,2,3,3,2,1]
For 5 columns: 5 / 2 = |2| ... 2 will be the peak, but as 5 is odd, there will be one peak: [1,2,3,2,1]

Row value calculation: The number of the row is taken as the value

At the end the summation of the two values will be the exact value for each position.

For example:
For 2 rows and 4 columns, it would be like this:

Position => name:(value)

__________________________________________

a1:(2+1) | a2:(2+2) | a3:(2+2) | a3:(2+1)
__________________________________________

b1:(1+1) | b2:(1+2) | b3:(1+2) | b3:(1+1)
__________________________________________


For 3 rows and 5 columns, it would be like this:

Position => name:(value)

_____________________________________________________

a1:(3+1) | a2:(3+2) | a3:(3+3) | a3:(3+2) | a3:(3+1)
_____________________________________________________

b1:(2+1) | b2:(2+2) | b3:(2+3) | b3:(2+2) | a3:(2+1)
_____________________________________________________

c1:(1+1) | c2:(1+2) | c3:(1+3) | c3:(1+2) | c3:(1+1)
_____________________________________________________


## Steps for running the application

1. Clone the repo > `git clone https://github.com/jvidalba1/concert_seats.git`

2. Run `bundle install` over the project directory

3. Setup and run migrations

  `rails db:setup`

  `rails db:migrate`

4. Run API application `rails server`

## Endpoints

### Find the best seat

Route:

> GET `localhost:3000/api/best_seats`

Params:

```
{
    "venue": {
        "layout": {
            "rows": 3,
            "columns": 6
        }
    },
    "seats": {
        "a1": {
            "id": "a1",
            "row": "a",
            "column": 1,
            "status": "AVAILABLE"
        },
        "b5": {
            "id": "b5",
            "row": "b",
            "column": 5,
            "status": "AVAILABLE"
        },
        "a3": {
            "id": "a3",
            "row": "a",
            "column": 3,
            "status": "AVAILABLE"
        },
        "a4": {
            "id": "a4",
            "row": "a",
            "column": 4,
            "status": "AVAILABLE"
        }
    }
}
```

Response:

```
{
    "status": "success",
    "best_seats": "a3"
}
```


### Find the best seats together given a group

Route:

> GET `localhost:3000/api/best_seats`

Params: Note: Add group option in venue > layout > group

```
{
    "venue": {
        "layout": {
            "rows": 3,
            "columns": 6,
            "group": 3
        }
    },
    "seats": {
        "a1": {
            "id": "a1",
            "row": "a",
            "column": 1,
            "status": "AVAILABLE"
        },
        "b5": {
            "id": "b5",
            "row": "b",
            "column": 5,
            "status": "AVAILABLE"
        },
        "a3": {
            "id": "a3",
            "row": "a",
            "column": 3,
            "status": "AVAILABLE"
        },
        "a4": {
            "id": "a4",
            "row": "a",
            "column": 4,
            "status": "AVAILABLE"
        }
    }
}
```

Response:

```
{
    "status": "success",
    "best_seats": [
        "a3",
        "a4",
        "a5"
    ]
}
```

## Unit tests

Run unit tests `rspec`
