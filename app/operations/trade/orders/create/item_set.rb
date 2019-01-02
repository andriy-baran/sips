module Trade::Orders
  class Create
    class ItemSet
      include Enumerable

      def self.from_hashes(items_hashes, is_return_order = false)
        item_set = new
        items_hashes.each { |item_hash| item_set << OpenStruct.new(item_hash) }

        item_set
      end

      def initialize(*items)
        @items = items
        @item_id_check_list = []
      end

      def <<(item)
        if item_id_check_list.include?(item.variant_id)
          fail Order::DuplicatedItemError.new(variant_id: item.variant_id)
        else
          item_id_check_list << item.variant_id
        end
        items << item
        self
      end

      def each(*args, &block)
        return to_enum(:each) unless block_given?
        items.each(*args, &block)
      end

      def each_with_variant(&block)
        Enumerator.new do |y|
          map do |item|
            y.yield(item, Variant.find(item.variant_id))
          end
        end.lazy.each(&block)
      end

      protected

      attr_reader :items, :item_id_check_list
    end
  end
end
