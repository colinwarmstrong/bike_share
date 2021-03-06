require 'rails_helper'

describe "A visitor visits '/trips'" do
  it 'they see the first 30 trips, the details of those trips, and a button to see more trips' do
    station_1 = Station.create(name: 'Test 1', dock_count: 20, city: 'Chicago', installation_date: Date.new(2017, 12, 12))
    station_2 = Station.create(name: 'Test 2', dock_count: 25, city: 'Chicago', installation_date: Date.new(2017, 11, 11))

    duration = 0
    start_date = Date.new(2018, 6, 6)
    end_date = Date.new(2018, 6, 6)
    start_station_id = station_1.id
    end_station_id = station_2.id
    bike_id = 1
    subscription_type = 0
    zip_code = 60446

    31.times do
      Trip.create!(
        duration: duration += 1,
        start_date: start_date,
        end_date: end_date,
        start_station_id: start_station_id,
        end_station_id: end_station_id,
        bike_id: bike_id += 1,
        subscription_type: subscription_type,
        zip_code: zip_code += 1)
      end

    visit trips_path

    expect(page).to have_content("#{Trip.all.last.duration}")
    expect(page).to have_content("#{Trip.all.last.start_date.strftime('%m/%d/%Y')}")
    expect(page).to have_content("#{Trip.all.last.end_date.strftime('%m/%d/%Y')}")
    expect(page).to have_content("#{Trip.all.last.start_station.name}")
    expect(page).to have_content("#{Trip.all.last.end_station.name}")
    expect(page).to have_content("#{Trip.all.last.bike_id}")
    expect(page).to have_content("#{Trip.all.last.subscription_type}")
    expect(page).to have_content("#{Trip.all.last.zip_code}")
    expect(page).to_not have_content("#{Trip.all.first.zip_code}")
    expect(page).to have_content('1')
    expect(page).to have_content('Previous')
    expect(page).to have_link('2')
    expect(page).to have_link('Next')
  end

  describe "an admin user visits '/trips'" do
    before :each do
      user = User.create!(username: 'happyharry', email: 'email@email.email', password: 'turtles', role: 1, first_name: 'josh', last_name: 'mcbeth', address: '1111 tommy ln')
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    end
    it 'they see all the information a regular user can see' do
      station1 = Station.create!(name: 'name', dock_count: 45, city: 'city', installation_date: Date.new(2017, 3, 10))
      station2 = Station.create!(name: 'eman', dock_count: 30, city: 'ytic', installation_date: Date.new(2013, 2, 15))
      trip_1 = Trip.create!(duration: 44, start_date: Date.new(2000, 2, 4), end_date: Date.new(2000, 2, 5), start_station_id: station1.id, end_station_id: station2.id, bike_id: 3, subscription_type: 0, zip_code: 67000)
      trip_2 = Trip.create!(duration: 120, start_date: Date.new(2000, 3, 6), end_date: Date.new(2000, 3, 6), start_station_id: station1.id, end_station_id: station2.id, bike_id: 8, subscription_type: 1, zip_code: 68686)

      visit trips_path

      expect(page).to have_content("#{trip_1.duration}")
      expect(page).to have_content("#{trip_1.start_date.strftime('%m/%d/%Y')}")
      expect(page).to have_content("#{trip_1.end_date.strftime('%m/%d/%Y')}")
      expect(page).to have_content("#{trip_1.start_station.name}")
      expect(page).to have_content("#{trip_1.end_station.name}")
      expect(page).to have_content("#{trip_1.bike_id}")
      expect(page).to have_content("#{trip_1.subscription_type}")
      expect(page).to have_content("#{trip_1.zip_code}")
      expect(page).to have_content("#{trip_2.duration}")
      expect(page).to have_content("#{trip_2.start_date.strftime('%m/%d/%Y')}")
      expect(page).to have_content("#{trip_2.end_date.strftime('%m/%d/%Y')}")
      expect(page).to have_content("#{trip_2.start_station.name}")
      expect(page).to have_content("#{trip_2.end_station.name}")
      expect(page).to have_content("#{trip_2.bike_id}")
      expect(page).to have_content("#{trip_2.subscription_type}")
      expect(page).to have_content("#{trip_2.zip_code}")
    end
    it 'they see a button next to each trip to edit that trip' do
      station1 = Station.create!(name: 'name', dock_count: 45, city: 'city', installation_date: Date.new(2017, 3, 10))
      station2 = Station.create!(name: 'eman', dock_count: 30, city: 'ytic', installation_date: Date.new(2013, 2, 15))
      trip_1 = Trip.create!(duration: 44, start_date: Date.new(2000, 2, 4), end_date: Date.new(2000, 2, 5), start_station_id: station1.id, end_station_id: station2.id, bike_id: 3, subscription_type: 0, zip_code: 67000)

      visit trips_path

      click_button 'Edit'

      expect(current_path).to eq(edit_admin_trip_path(trip_1))
    end
    it 'they see a button next to each trip to delete that trip' do
      station1 = Station.create!(name: 'name', dock_count: 45, city: 'city', installation_date: Date.new(2017, 3, 10))
      station2 = Station.create!(name: 'eman', dock_count: 30, city: 'ytic', installation_date: Date.new(2013, 2, 15))
      trip_1 = Trip.create!(duration: 44, start_date: Date.new(2000, 2, 4), end_date: Date.new(2000, 2, 5), start_station_id: station1.id, end_station_id: station2.id, bike_id: 3, subscription_type: 0, zip_code: 67000)

      visit trips_path

      click_button 'Delete'

      expect(current_path).to eq(trips_path)
      expect(page).to have_content("Successfully deleted trip")
    end
  end
end
