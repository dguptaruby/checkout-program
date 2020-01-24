require './basket'
require 'shared/product'

RSpec.describe Basket do
  include_context 'products'

  describe 'Basket module' do

    let(:basket) { Basket.new }

    before do
      basket.add_item(fruit_tea)
      basket.add_item(apple)
      basket.add_item(coffee)
    end

    it 'calculates the total price of the scanned items' do
      expect(basket.grand_total).to eq(17.45)
    end

    it 'return fruit tea item code not empty' do
      expect(basket.items_by_code('FR1')).not_to be_empty
    end

    it 'return empty on random code' do
      expect(basket.items_by_code('FT')).to be_empty
    end
  end
end
