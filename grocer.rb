def consolidate_cart(cart)
  ordered_cart = {}
  cart.each do |items_hash|
  	items_hash.each do |item, price_hash|
  	  if ordered_cart.key?(item) == false
  	  	 ordered_cart[item] = price_hash
  	  	 ordered_cart[item][:count] = 1
  	  else
  	     ordered_cart[item][:count] += 1
  	  end
  	end
  end
  ordered_cart
end


def apply_coupons(cart, coupons)
  cart_with_coupon = {}
  cart.each do |item, data|
	coupons.each do |coupon|
	  if item == coupon[:item] && data[:count] >= coupon [:num]
		 cart[item][:count] = cart[item][:count] - coupon[:num]
		 if cart_with_coupon[item + " W/COUPON"]
            cart_with_coupon[item + " W/COUPON"][:count] += 1
      	 else
      	  	cart_with_coupon[item + " W/COUPON"] ={:price => coupon[:cost], :clearance => cart[item][:clearance], :count => 1}
      	 end
      end
    end
    cart_with_coupon[item] = data
  end
  cart_with_coupon
end

#"AVOCADO W/COUPON" => {:price => 5.0, :clearance => true, :count => 1},


def apply_clearance(cart)
  clearance_cart = {}
  cart.each do |item, data|
    clearance_cart[item] = {}
    data.each do |info|
      if cart[item][:clearance]
        clearance_cart[item][:price] = (cart[item][:price] * 0.80).round(2)
      else
        clearance_cart[item][:price] = cart[item][:price]
      end
      clearance_cart[item][:clearance] = cart[item][:clearance]
      clearance_cart[item][:count] = cart[item][:count]
    end
  end	
  clearance_cart
end


def checkout(cart, coupons)
  cart = consolidate_cart(cart)
  cart1 = apply_coupons(cart, coupons)
  cart2 = apply_clearance(cart1)
  
  total_cost = 0
  
  cart2.each do |item, data|
    total_cost += data[:price] * data[:count]
  end
  
  total_cost > 100 ? total_cost * 0.9 : total_cost
end
	
