class Menu < ApplicationRecord

  def view_item_and_price
    self.item + ' (税込' + self.price.to_s + '円)'
  end

end
