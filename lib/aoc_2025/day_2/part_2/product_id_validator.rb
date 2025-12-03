module DayTwo
  module PartTwo
    class ProductIdValidator
      attr_accessor :product_id_range

      def initialize(product_id_range)
        self.product_id_range = product_id_range
      end

      def invalid_ids
        product_id_range.each.filter do |id|
          id.to_s.match(/^(\w+)\1+$/)
        end
      end
    end
  end
end
