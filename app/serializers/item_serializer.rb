class ItemSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :name, :description, :unit_price, :merchant_id
  set_type :item
  set_key_transform :dash
end
