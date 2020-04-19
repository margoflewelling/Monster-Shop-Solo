class Cart
  attr_reader :contents

  def initialize(contents)
    @contents = contents
  end

  def add_item(item)
    @contents[item] = 0 if !@contents[item]
    @contents[item] += 1
  end

  def total_items
    @contents.values.sum
  end

  def items
    item_quantity = {}
    @contents.each do |item_id,quantity|
      item_quantity[Item.find(item_id)] = quantity
    end
    item_quantity
  end

  def subtotal(item)
    item.price * @contents[item.id.to_s] * (1-best_discount(item))
  end

  def total
    @contents.sum do |item_id,quantity|
      subtotal(Item.find(item_id))
    end
  end

  def best_discount(item)
    quantity = @contents[item.id.to_s]
    applicable_discounts = item.find_discounts.find_all {|discount| quantity >= discount.min_quantity}
    if applicable_discounts != []
      best_discount = applicable_discounts.max_by{|discount| discount[:percentage]}
      percent_off = best_discount.percentage.to_f/100
    else
      percent_off = 0
    end
    percent_off
  end

end
