module Zuora
  class Account < ZObject
    def billTo
      @billTo ||= Contact.find(self.billToId)
    end

    def soldTo
      @soldTo ||= Contact.find(self.soldToId)
    end

    def subscriptions
      @subscriptions ||= Subscription.where(:accountid => self.id)
    end

    def invoices
      @invoices ||= Invoice.where(:accountid => self.id)
    end

    def invoices_with_balance
      @invoices_with_balance ||= Invoice.where("accountId = '#{self.id}' AND Balance > 0")
    end

    def payment_methods
      @payment_methods ||= PaymentMethod.where(:accountid => self.id)
    end

    def contacts
      @contacts ||= Contact.where(:accountid => self.id)
    end
  end
end
