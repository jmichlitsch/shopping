class Market

  attr_reader :name,
              :vendors
  def initialize(name)
    @name = name
    @vendors = []
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
end
