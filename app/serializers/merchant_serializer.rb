class MerchantSerializer
  include FastJsonapi::ObjectSerializer
  attribute :name
  set_type :merchant
  set_key_transform :dash
end
