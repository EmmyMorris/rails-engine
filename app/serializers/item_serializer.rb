class ItemSerializer < ActiveModel::Serializer
  # type :item
  attributes :id, :name, :description, :unit_price, :merchant
  # def self.format_items(items)
  #   items.map do |item|
  #     {
  #       id: item.id,
  #       name: item.name,
  #       description: item.description,
  #       unit_price: item.unit_price,
  #       merchant_id: item.merchant_id
  #     }
  #   end
  # end
end
