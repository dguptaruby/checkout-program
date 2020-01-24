# frozen_string_literal: true

RSpec.shared_context 'products' do
  let(:apple) do
    Product.new(
      'AP1',
      'Apple',
      3.11
    )
  end

  let(:coffee) do
    Product.new(
      'CF1',
      'Coffee',
      11.23
    )
  end

  let(:fruit_tea) do
    Product.new(
      'FR1',
      'Fruit tea',
      3.11
    )
  end

  let(:products) { [apple, coffee, fruit_tea] }
end
