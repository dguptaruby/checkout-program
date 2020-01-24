# frozen_string_literal: true

require_relative 'shop'

# Checkout module
class Checkout
  attr_accessor :basket, :pricing_rules, :total

  def initialize(pricing_rules)
    self.pricing_rules = pricing_rules
    self.basket = Basket.new
    self.total = 0
  end

  def total_price
    offers = pricing_rules.select { |rule| rule.amount_offer_applied?(total) }
    if offers.any?
      discount = offers.map(&:offer_discount).reduce(&:+)
      self.total -= total * discount / 100.00
    end
    total
  end

  def scan(item)
    basket.add_item(item)
    cal_price
  end

  class << self
    def checkout(product_codes=nil)
      co = Checkout.new(Offer.pricing_rules)
      codes = product_codes || %w[FR1 AP1 CF1 AP1 AP1]
      codes.each { |code| co.scan(Product.find_by_code(code)) }
      co.total_price
    end
  end

  private

  def cal_price
    self.total =
      basket.items.collect { |info| offer_price(info) }.sum
  end

  def match_rules(item_code, frequency)
    Offer.applied_offers(item_code, frequency)
  end

  def match_rules?(item_code, frequency)
    match_rules(item_code, frequency).any?
  end

  def item_price(price, frequency)
    price * frequency
  end

  def item_offer_price(price, frequency, rule = nil)
    discount = rule&.offer_discount || 0
    ((price / 100.0) * (100.0 - discount)) * frequency
  end

  def total_item_price(price, frequency, rule = nil)
    factor = rule&.offer_factor || 1
    without_offer = frequency % factor
    item_price(price, without_offer) +
      item_offer_price(price, frequency - without_offer, rule)
  end

  def offer_price(item_info)
    item = item_info[:item]
    frequency = item_info[:frequency]
    unless match_rules?(item.code, frequency)
      return total_item_price(item.price, frequency)
    end

    item_prices = match_rules(item.code, frequency).collect do |rule|
      total_item_price(item.price, frequency, rule) || 0
    end
    item_prices.sum
  end
end

result = Checkout.checkout
puts "Total payable amount: #{result}"
