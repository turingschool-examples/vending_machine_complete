require 'rails_helper'

RSpec.describe "Snack Show Page" do
  describe "When I visit a snack show page" do
    before(:each) do
      @owner = Owner.create(name: "Sam's Snacks")
      @dons  = @owner.machines.create(location: "Don's Mixed Drinks")
      @mikes  = @owner.machines.create(location: "Mike's Snacks n Stuff")
      @calvins  = @owner.machines.create(location: "Cals snacks")

      @cheetos = Snack.create(name: "Cheetos", price: 2.5)
      @pretzels = Snack.create(name: "Pretzels", price: 2)

      @dons.snacks << @cheetos
      @mikes.snacks << @cheetos
      @dons.snacks << @pretzels

      visit "/snacks/#{@cheetos.id}"
    end
    it "I see the name and price of the snack" do
      expect(page).to have_content(@cheetos.name)
      expect(page).to have_content("Price: $2.50")
    end
    it "I see a list of locations with vending machiens that carry that snack" do
      within("#machines-with-snacks") do
        expect(page).to have_content(@dons.location)
        expect(page).to have_content(@mikes.location)
        expect(page).to_not have_content(@calvins.location)
      end
    end
    it "I see the average price for snacks in those vending machines" do
      within(".machine-#{@mikes.id}") do
        expect(page).to have_content("Average Price At This Location: $2.50")
      end
      within(".machine-#{@dons.id}") do
        expect(page).to have_content("Average Price At This Location: $2.25")
      end
    end
    it "I see a count of the different kinds of snacks in that vending machine" do
      within(".machine-#{@mikes.id}") do
        expect(page).to have_content("Count of Snacks: 1")
      end
      within(".machine-#{@dons.id}") do
        expect(page).to have_content("Count of Snacks: 2")
      end
    end
  end
end



# User Story 3 of 3
#
# As a visitor
# When I visit a snack show page
# I see the name of that snack
#   and I see the price for that snack
#   and I see a list of locations with vending machines that carry that snack
#   and I see the average price for snacks in those vending machines
#   and I see a count of the different kinds of items in that vending machine.
