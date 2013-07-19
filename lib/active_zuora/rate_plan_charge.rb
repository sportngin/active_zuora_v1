module Zuora
  class RatePlanCharge < ZObject
    
    exclude_query_attributes :overagePrice, :includedUnits, :discountAmount, :discountPercentage, :price

    def rate_plan
      @rate_plan ||= RatePlan.find(self.ratePlanId)
    end

    def product_rate_plan_charge
      @product_rate_plan_charge ||= ProductRatePlanCharge.find(self.productRatePlanChargeId)
    end

    def rate_plan_charge_tier
      @rate_plan_charge_tier ||= RatePlanChargeTier.where(:ratePlanChargeId => id)
    end

    def usages
      @usages ||= Usage.where(:chargeId => id)
    end

    def unload_usages
      @usages = nil
      self
    end

    def total_price
      (quantity || 1) * rate_plan_charge_tier.first.price
    end

    def list_price
      product_rate_plan_charge.product_rate_plan_charge_tiers.first.price
    end

    def total_list_price
      (quantity || 1) * list_price
    end

    def discount?
      price < list_price
    end

    def discount_percent
      list_price.zero? ? nil : (1 - price / list_price) * 100
    end

  end
end
