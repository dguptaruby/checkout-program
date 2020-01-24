# frozen_string_literal: true

# Offer module for sales
class Offer
  attr_reader :offer_factor, :offer_type, :product_code, :offer_discount

  class << self
    def pricing_rules
      @pricing_rules = [
        new(2, :one_free, 'FR1', 50),
        new(3, :cost_per_item, 'AP1', 10),
        new(60, :amount, nil, 20)
      ]
    end

    def applied_offers(item_code, frequency)
      pricing_rules.select do |rule|
        rule.product_code == item_code &&
          rule.offer_factor <= frequency
      end
    end
  end

  def amount_offer_applied?(total)
    offer_type == :amount && offer_factor <= total
  end

  def item_offer_applied?(item_code)
    product_code == item_code
  end

  # We can set this as dynamic as well by setting up a new table for the same.
  def initialize(factor, type, product_code, discount)
    @offer_factor = factor
    @offer_type = type
    @product_code = product_code
    @offer_discount = discount
  end
end
