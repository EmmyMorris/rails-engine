# frozen_string_literal: true

class Merchant < ApplicationRecord
  validates_presence_of :name
  has_many :items
  has_many :invoice_items, through: :items
  has_many :invoices, through: :invoice_items
  has_many :customers, through: :invoices
  has_many :transactions, through: :invoices

  def self.most_revenue(_quantity)
    joins(invoices: %i[invoice_items transactions])
      .where('transactions.result = ?', 'success')
      .where('invoices.status = ?', 'shipped')
      .group(:id)
      .select('merchants.*, sum(invoice_items.quantity * invoice_items.unit_price) AS revenue')
      .order('revenue DESC')
      .limit(10)
  end
end
