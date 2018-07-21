require 'rails_helper'

describe "A visitor visits '/conditions'" do
  it 'they see all conditions and their attributes' do
    condition_1 = Condition.create(
      date: Date.new(2017, 12, 11),
      max_temperature: 75.0,
      mean_temperature: 65.0,
      min_temperature: 55.0,
      mean_humidity: 75.0,
      mean_visibility: 10.0,
      mean_wind_speed: 11.0,
      precipitation: 0.23)
    condition_2 = Condition.create(
      date: Date.new(2016, 11, 10),
      max_temperature: 70.0,
      mean_temperature: 60.0,
      min_temperature: 50.0,
      mean_humidity: 65.0,
      mean_visibility: 5.0,
      mean_wind_speed: 12.0,
      precipitation: 0.12)

    visit conditions_path

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
