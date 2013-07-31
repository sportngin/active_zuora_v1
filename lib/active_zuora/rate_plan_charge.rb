module Zuora
  class RatePlanCharge < ZObject
    
    exclude_query_attributes :overagePrice, :includedUnits, :discountAmount, :discountPercentage, :price

    def rate_plan
      @rate_plan ||= RatePlan.find(self.ratePlanId)
    end

    def rate_plan_charge_tier
      query = charge_tier_query("ratePlanChargeId", id)
      @rate_plan_charge_tier ||= RatePlanChargeTier.where(query).first
    end

    def product_rate_plan_charge_tier
      query = charge_tier_query("productRatePlanChargeId", productRatePlanChargeId)
      @product_rate_plan_charge_tier ||= ProductRatePlanChargeTier.where(query).first
    end

    def charge_tier_query(identifier_name, identifier_value)
      query = "#{identifier_name} = '#{identifier_value}'"
      query += " and endingUnit >= #{charge_quantity} and startingUnit <= #{charge_quantity}" if chargeModel == "Volume Pricing"
      query
    end

    def product_rate_plan_charge
      @product_rate_plan_charge ||= ProductRatePlanCharge.find(self.productRatePlanChargeId)
    end

    def usages
      @usages ||= Usage.where(:chargeId => id)
    end

    def unload_usages
      @usages = nil
      self
    end

    def charge_quantity
      quantity || 1
    end

    def price
      super || rate_plan_charge_tier.price
    end

    def total_price
      charge_quantity * price
    end

    def list_price
      product_rate_plan_charge_tier.price
    end

    def total_list_price
      charge_quantity * list_price
    end

    def discount?
      price < list_price
    end

    def discount_percent
      list_price.zero? ? nil : (1 - price / list_price) * 100
    end

  end
end
