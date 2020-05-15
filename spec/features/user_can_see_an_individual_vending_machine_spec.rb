require 'rails_helper'

RSpec.describe 'When a user visits a vending machine show page', type: :feature do
  scenario 'they see the location of that machine' do
    owner = Owner.create(name: "Sam's Snacks")
    dons  = owner.machines.create(location: "Don's Mixed Drinks")

    visit machine_path(dons)

    expect(page).to have_content("Don's Mixed Drinks Vending Machine")
  end
  it 'I see the name of all of the snacks associated with that vending machine along with their price' do
    owner = Owner.create(name: "Sam's Snacks")
    dons  = owner.machines.create(location: "Don's Mixed Drinks")

    cheetos = Snack.create(name: "Cheetos", price: 2.5)
    pretzels = Snack.create(name: "Pretzels", price: 2)

    dons.snacks << cheetos
    dons.snacks << pretzels

    visit "/machines/#{dons.id}"
    # visit machine_path(dons)

    within "#snacks-#{cheetos.id}" do
      expect(page).to have_content(cheetos.name)
      expect(page).to have_content("Price: $2.50")
    end
    within "#snacks-#{pretzels.id}" do
      expect(page).to have_content(pretzels.name)
      expect(page).to have_content("Price: $2.00")
    end
  end

  it "I also see an average price for all of the snacks in that machine" do
    owner = Owner.create(name: "Sam's Snacks")
    dons  = owner.machines.create(location: "Don's Mixed Drinks")

    cheetos = Snack.create(name: "Cheetos", price: 2.5)
    pretzels = Snack.create(name: "Pretzels", price: 2)

    dons.snacks << cheetos
    dons.snacks << pretzels

    visit "/machines/#{dons.id}"

    expect(page).to have_content("Average Snack Price: $2.25")
  end
end
# User Story 2 of 3
#
# As a visitor
# When I visit a vending machine show page
# I also see an average price for all of the snacks in that machine
