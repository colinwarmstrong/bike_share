require 'rails_helper'

describe "A user visits '/bike-shop'" do
  describe 'as a visitor' do
    it 'they see all accessories and their information' do
      accessory_1 = Accessory.create(title: 'Horn', description: 'Let people know you are on a bike', price: 12.50)
      accessory_2 = Accessory.create(title: 'Water Bottle', description: 'Stay hydrated', price: 8.50)

      visit bike_shop_path

      expect(page).to have_content(accessory_1.title)
      expect(page).to have_content(accessory_1.description)
      expect(page).to have_content("Price: $#{accessory_1.price}")
      expect(page).to have_content(accessory_2.title)
      expect(page).to have_content(accessory_2.description)
      expect(page).to have_content("Price: $#{accessory_2.price}")
    end
    it 'they see a button to add items to cart' do
      accessory_1 = Accessory.create(title: 'Horn', description: 'Let people know you are on a bike', price: 12.50)

      visit bike_shop_path

      expect(page).to have_button 'Add to Cart'
    end
    it 'they cannot add retired items to cart' do
      accessory_1 = Accessory.create(title: 'Horn', description: 'Let people know you are on a bike', price: 12.50, retired?: true)

      visit bike_shop_path

      expect(page).to have_content('Accessory Retired')
      expect(page).to_not have_button 'Add to Cart'
    end
  end
end
