class ItemSerializer
  def self.format_items(items)
    items.map do |item|
      {
        id: item.id,
        name: item.name,
        description: item.description,
        unit_price: item.unit_price
      }
    end
  end
end
