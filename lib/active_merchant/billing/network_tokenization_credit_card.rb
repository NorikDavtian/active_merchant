module ActiveMerchant #:nodoc:
  module Billing #:nodoc:
    class NetworkTokenizationCreditCard < CreditCard
      # A +NetworkTokenizationCreditCard+ object represents a tokenized credit card
      # using the EMV Network Tokenization specification, http://www.emvco.com/specifications.aspx?id=263.
      #
      # It includes all fields of the +CreditCard+ class with additional fields for
      # verification data that must be given to gateways through existing fields (3DS / EMV).
      #
      # The only tested usage of this at the moment is with an Apple Pay decrypted PKPaymentToken,
      # https://developer.apple.com/library/ios/documentation/PassKit/Reference/PaymentTokenJSON/PaymentTokenJSON.html

      # These are not relevant (verification) or optional (name) for Apple Pay
      self.require_verification_value = false
      self.require_name = false

      attr_accessor :payment_cryptogram, :eci, :transaction_id
      attr_writer :source

      SOURCES = [:apple_pay, :android_pay]

      def source
        if defined?(@source) && SOURCES.include?(@source)
          @source
        else
          :apple_pay
        end
      end

      def credit_card?
        true
      end

      def type
        "network_tokenization"
      end

      def self.test_credit_card
        new(
          :number => "4111111111111111",
          :month => 12,
          :year => 20,
          :first_name => 'John',
          :last_name => 'Smith',
          :brand => 'visa',
          :payment_cryptogram => 'EHuWW9PiBkWvqE5juRwDzAUFBAk='
        )
      end
    end
  end
end
