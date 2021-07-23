# frozen_string_literal: true

require 'rails_helper'

RSpec.describe InvoiceItem, type: :model do
  describe 'validations' do
    it { should validate_presence_of :item_id }
    it { should validate_presence_of :invoice_id }
    it { should validate_presence_of :quantity }
    it { should validate_presence_of :unit_price }
  end
  describe 'relationships' do
    it { should belong_to :item }
    it { should belong_to :invoice }
    it { should have_one(:merchant).through(:item) }
  end
end
