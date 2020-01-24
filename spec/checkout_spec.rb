require './checkout'
require 'shared/product'

RSpec.describe Checkout do
  include_context 'products'

  describe 'Scan items' do

    it 'return total of fruit tea as by one get one' do
      response = Checkout.checkout(['FR1', 'FR1'])
      expect(response).to eql(3.11)
    end

    it 'return total of apple as price reduce by each item offer' do
      response = Checkout.checkout(['AP1', 'AP1', 'AP1'])
      expect(response).to eql(13.50)
    end

    it 'return total after multiple offer' do
      response = Checkout.checkout(['FR1', 'AP1', 'CF1', 'AP1', 'AP1'])
      expect(response).to eql(27.84)
    end
  end
end
