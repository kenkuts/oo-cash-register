class CashRegister
    attr_writer :total
    attr_reader :discount, :items, :running_total

    def initialize(discount=0)
        @discount = discount
        @total = 0
        @items = []
        @running_item = {}
        @running_total = []
    end

    def add_item(item, price, quantity=1)
        @running_total << (price * quantity)
        @running_item["#{item}"] ||= quantity
        @total += (price * quantity)
        quantity.times { @items << item }
    end

    def total
        @total
    end

    def apply_discount
        if @discount == 0
            "There is no discount to apply."
        else
            @total = (@total - (@total * (@discount / 100.00).round(2)))
            "After the discount, the total comes to $#{@total.floor}."
        end
    end  

    def items
        @items
    end

    def void_last_transaction
        @total -= @running_total[@running_total.length - 1]
        @running_total.pop
        @running_item.values.last.times { @items.pop }
        @running_item.delete("#{@running_item.keys.last}")
    end
end 