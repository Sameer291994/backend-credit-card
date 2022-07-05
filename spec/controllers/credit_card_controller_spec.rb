require 'rails_helper'

RSpec.describe 'CreditCards', type: :request do
  describe 'GET /index' do
    before do
      FactoryBot.create(:credit_card)
      get '/credit_cards'
    end

    it 'returns all posts' do
      expect(JSON.parse(response.body).size).to eq(1)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST /create' do
    context 'with valid parameters' do
      let!(:my_card) { FactoryBot.create(:credit_card) }

      before do
        post '/credit_cards', params:
          { credit_card: {
            name: my_card.name,
            card_number: '4556088799801886',
            limit: 6.4
          } }
      end

      it 'returns the name' do
        expect(JSON.parse(response.body)['name']).to eq(my_card.name)
      end

      it 'returns the card_number' do
        expect(JSON.parse(response.body)['card_number']).to eq('4556088799801886')
      end
      it 'returns the limit' do
        expect(JSON.parse(response.body)['limit']).to eq('6.4')
      end

      it 'returns a created status' do
        expect(response).to have_http_status(:created)
      end
    end

    context 'with invalid parameters' do
      before do
        post '/credit_cards', params:
          { credit_card: {
            name: '',
            card_number: '111111',
            limit: 0.1
          } }
      end

      it 'returns a unprocessable entity status' do
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end