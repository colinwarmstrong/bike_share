require 'rails_helper'

describe "A visitor visits '/conditions/:id'" do
  it 'they the attributes for the conditinon' do
    condition_1 = Condition.create(
      date: Date.new(2017, 12, 11),
      max_temperature: 75.0,
      mean_temperature: 65.0,
      min_temperature: 55.0,
      mean_humidity: 75.0,
      mean_visibility: 10.0,
      mean_wind_speed: 11.0,
      precipitation: 0.23)

    visit condition_path(condition_1)

    expect(page).to have_content("Date: #{condition_1.date}")
    expect(page).to have_content("Max Temperature: #{condition_1.max_temperature}")
    expect(page).to have_content("Mean Temperature: #{condition_1.mean_temperature}")
    expect(page).to have_content("Min Temperature: #{condition_1.min_temperature}")
    expect(page).to have_content("Mean Humidity: #{condition_1.mean_humidity}")
    expect(page).to have_content("Mean Visibility: #{condition_1.mean_visibility}")
    expect(page).to have_content("Mean Wind Speed: #{condition_1.mean_wind_speed}")
    expect(page).to have_content("Precipitation: #{condition_1.precipitation}")
  end
end
