# frozen_string_literal: true

class InvoiceItem < ApplicationRecord
  validates_presence_of :invoice_id,
                        :item_id,
                        :quantity,
                        :unit_price

  belongs_to :invoice
  belongs_to :item
  has_one :merchant, through: :item
end
