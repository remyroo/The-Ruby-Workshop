# frozen_string_literal: true

def can_purchase?(amount_in_bank, cost_of_item)
  amount_in_bank >= cost_of_item
end

bank_balance = 100

cost_of_item = 200

if can_purchase?(bank_balance, cost_of_item)
  puts 'You can purchase this item'
else
  puts "Sorry, you don't have enough money to buy this item"
end
