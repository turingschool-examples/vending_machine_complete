require 'rails_helper'

RSpec.describe Machine, type: :model do
  describe 'validations' do
    it { should validate_presence_of :location }
    it { should belong_to :owner }
  end
  describe 'relationships' do
    it {should have_many :machine_snacks}
    it {should have_many(:snacks).through(:machine_snacks)}
  end
  describe 'instance methods' do
    it "can average snack prices" do
        
      owner = Owner.create(name: "Sam's Snacks")
      dons  = owner.machines.create(location: "Don's Mixed Drinks")

      cheetos = Snack.create(name: "Cheetos", price: 2.5)
      pretzels = Snack.create(name: "Pretzels", price: 2)

      dons.snacks << cheetos
      dons.snacks << pretzels

      expect(dons.average_snack_price).to eq(2.25)
    end

  end
end
