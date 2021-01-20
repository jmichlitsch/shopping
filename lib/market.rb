require 'date'
class Market

  attr_reader :name,
              :vendors,
              :date
  def initialize(name)
    @name = name
    @vendors = []
    date = Date.today.strftime("%d/%m/%y").to_s
  end

  def add_vendor(vendor)
    @vendors << vendor
  end

  def vendor_names
    names = []
    @vendors.each do |vendor|
      names << vendor.name
    end
    names
  end

  def vendors_that_sell(item)
    @vendors.find_all do |vendor|
      vendor.check_stock(item) > 0
    end
  end

  def total_inventory
    inventory = {}
    @vendors.each do |vendor|
      vendor.inventory.each do |item, quantity|
      if inventory[item].nil?
        inventory[item] = {quantity: 0, vendors: []}
      end

      inventory[item][:quantity] += quantity
      inventory[item][:vendors].push(vendor)
      end
    end
    inventory
  end

  def overstocked_items
    items =[]
    total_inventory.each do |item, attributes|
      items << item if attributes[:quantity] > 50 && attributes[:vendors].length >1
    end
    items
  end

  def sorted_item_list
    items = vendors.map do |vendor|
      vendor.inventory.keys
    end.flatten.uniq

    items.map do |item|
      item.name
    end.sort
  end

 def sell(item, quantity)
   vendors_that_sell(item).each do |vendor|
     if vendor.check_stock(item) >= quantity
       vendor.sell(item,quantity)
       quantity = 0
     else
       quantity -= vendor.check_stock(item)
       vendor.sell(item, vendor.check_stock(item))
     end
    end
 end
end
