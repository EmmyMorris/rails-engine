class MerchantSerializer < ActiveModel::Serializer
  # type :merchant
  attributes :id, :name
  # def self.format_merchants(merchants)
  #   merchants.map do |merchant|
  #     {
  #       id: merchant.id,
  #       name: merchant.name
  #     }
  #   end
  # end
end
