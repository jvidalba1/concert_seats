require 'rails_helper'

RSpec.describe VenuesController, type: :controller do

  let(:params) {
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
          "id": "a2",
          "row": "a",
          "column": 2,
          "status": "AVAILABLE"
        }
      }
    }
  }

  describe 'GET /api/best_seats' do

    context 'individual seat' do
      before { get 'best_seats', params: params }

      it 'gets HTTP status 200' do
        expect(response.status).to eq 200
      end

      it 'receives a json with the best seat available' do
        expect(JSON.parse(response.body)['best_seats']).to eq "a3"
      end
    end

    context 'group seats together' do

      before do
        params[:venue][:layout][:group] = 3
        get 'best_seats', params: params
      end

      it 'gets HTTP status 200' do
        expect(response.status).to eq 200
      end

      it 'receives a json with the best seat available' do
        expect(JSON.parse(response.body)['best_seats']).to eq ["a3", "a4", "a5"]
      end
    end
  end

end
