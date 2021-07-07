require "pry"
def consolidate_cart(cart)
  # code here
  new_hash = {}
  cart.each do |item|
    if new_hash.keys.include?(item.keys[0])
       new_hash[item.keys[0]][:count] += 1
    else
      new_hash[item.keys[0]] = item.values[0]
      new_hash[item.keys[0]][:count] = 1
    end
  end
new_hash
end
# consolidate_cart(cart)

def apply_coupons(cart, coupons)
  cart_with_coupon = {}
  coupon_text = " W/COUPON"
  cart.each do |product_key, product_data|
	 coupons.each do |coupon|
	  if product_key == coupon[:item] && product_data[:count] >= coupon[:num]
		 cart[product_key][:count] = cart[product_key][:count] - coupon[:num]
		 if cart_with_coupon[product_key + "#{coupon_text}"]
       cart_with_coupon[product_key + "#{coupon_text}"][:count] += 1
     else
       cart_with_coupon[product_key + "#{coupon_text}"] = {
         :price => coupon[:cost],
         :clearance => cart[product_key][:clearance],
         :count => 1
       }
    end
      end
    end
    cart_with_coupon[product_key] = product_data
  end
  cart_with_coupon
end

def apply_clearance(cart)
  # code here
  clearance_applied = cart
  cart.each do |product, product_data|
    # binding.pry
    if product_data[:clearance] == true
      clearance_applied[product][:price] = (cart[product][:price]*0.8).round(2)
    end
  end
  clearance_applied
end
# apply_clearance(from)

def checkout(cart, coupons)
  # code here
  cart = consolidate_cart(cart)
  cart = apply_coupons(cart, coupons)
  cart = apply_clearance(cart)

  total = 0
  cart.each do |product, product_data|
    total += (product_data[:price]*product_data[:count])
  end
  total > 100 ? total*0.9 : total
end
