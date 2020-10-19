 class Item
   attr_accessor :name
   attr_accessor :weight
   attr_accessor :value
   def initialize(name, weight, value)
     @name = name
     @weight = weight
     @value = value
   end
 end

 def knapsack(items, max_capacity)
   table = []
   (items.length + 1).times do 
     table << Array.new(max_capacity + 1, 0.0)
   end
   items.each_with_index do |item, index|
     (1..max_capacity).each do |capacity|
       previous_items_value = table[index][capacity]
       if capacity >= item.weight
         value_freeing_weight_for_item = table[index][capacity - item.weight]
         table[index + 1][capacity] = [value_freeing_weight_for_item + item.value, previous_items_value].max
       else
         table[index + 1][capacity] = previous_items_value
       end
     end 
   end
   solution = []
   capacity = max_capacity
   (1..items.length).reverse_each do |i|
     if table[i - 1][capacity] != table[i][capacity]
       solution.append(items[i - 1])
       capacity -= items[i - 1].weight
     end
   end
   solution
 end

 items = [Item.new("television", 50, 200),
          Item.new("candlestick", 2, 300),
          Item.new("stero", 35, 400),
          Item.new("laptop", 3, 1000),
          Item.new("food", 15, 50),
          Item.new("clothing", 20, 800),
          Item.new("jewelry", 1, 4000),
          Item.new("books", 100, 300),
          Item.new("printer", 18, 30),
          Item.new("refrigerator", 200, 700),
          Item.new("painting", 10, 1000)]

 items_2 = [Item.new("matches", 1, 5),
            Item.new("flashlight", 2, 10),
            Item.new("book", 1, 15)]

 puts "#{knapsack(items, 75)}"
