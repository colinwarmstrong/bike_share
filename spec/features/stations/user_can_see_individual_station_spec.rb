require 'rails_helper'

describe 'user can go to station show page' do
  it 'can see all attributes' do
    station = Station.create!(name: '2name', dock_count: 45, city: 'city', installation_date: Date.new(2017, 3, 10))

    visit station_path(station)

    expect(current_path).to eq('/stations/2name')
    expect(page).to have_content(station.name)
    expect(page).to have_content(station.dock_count)
    expect(page).to have_content(station.city)
    expect(page).to have_content(station.installation_date)
  end
  it 'can see the number of rides started at this station' do
    station = Station.create!(name: '2name', dock_count: 45, city: 'city', installation_date: Date.new(2017, 3, 10))
    Trip.create!(duration: 44, start_date: Date.new(2000, 2, 4), end_date: Date.new(2000, 2, 5), start_station_id: station.id, end_station_id: station.id, bike_id: 3, subscription_type: 1, zip_code: 68686)
    Trip.create!(duration: 44, start_date: Date.new(2000, 2, 4), end_date: Date.new(2000, 2, 5), start_station_id: station.id, end_station_id: station.id, bike_id: 3, subscription_type: 1, zip_code: 68686)

    visit station_path(station)

    expect(page).to have_content("Number of Rides Started Here: #{Trip.all.count}")
  end
end
