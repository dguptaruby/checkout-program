# frozen_string_literal: true
require 'byebug'
require_relative 'product'

# Basket module
class Basket
  attr_reader :items

  def initialize
    @items = []
  end

  def add_item(item)
    item_hash = items_by_code(item.code).first
    if item_hash
      frequency = item_hash[:frequency] + 1
      item_hash.merge!(frequency: frequency)
    else
      items << { item: item, frequency: 1 }
    end
  end

  def items_by_code(item_code)
    items.select { |item| item[:item].code == item_code }
  end

  def grand_total
    items.collect{ |item| item[:item].price}.sum
  end

  def to_json(*_args)
    JSON.dump(items: items.collect { |item| item[:item] })
  end

  private

  def item_frequency(item_code)
    items_by_code(item_code)&.length
  end
end
