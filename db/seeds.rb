# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)

service_groups = ServiceGroup.create([{ :name => 'John Gardner Center', :address1 => '505 Lausen Mall',:city => 'Stanford', :state => 'CA', :zip => '94305-3083', :phone => '650.723.1137', :inception_date => '2000-09-01'},{:name => 'YDA at the John Gardner Center', :address1 => '505 Lausen Mall',:city => 'Stanford', :state => 'CA', :zip => '94305-3083', :phone => '650.723.1137', :inception_date => '2000-09-01'}])  

ServicePerson.create([{ :service_group_id => service_groups[0].id, :first_name => 'Laura',:last_name => 'Ma', :email => 'nowhere@nowhere.com', :phone => '650.723.3682'},{:service_group_id => service_groups[0].id, :first_name => 'Amy',:last_name => 'Gerstein', :email => 'nowhere@nowhere.com', :phone => '650.723.3682'}])  

Zip.create([{:code => '94305-3083', :city => 'Stanford', :state => 'CA', :lat => 37.426394, :lon => -122.173745}])

Program.create([{:name => 'soccer', :description => 'running around in packs', :start_date => '2010-07-01', :end_date => '2010-07-01', :start_time => 16, :end_time => 20, :repeats => 1, :range => '2010-07-01', :age_min => 8, :age_max => 14, :cost => 0, :address1 => '505 Lausen Mall',:city => 'Stanford', :state => 'CA', :zipcode => '94305-3083', :zip_id => 1},{:name => 'Arts and crafts', :description => 'paints and drawing', :start_date => '2010-07-08', :end_date => '2010-07-08', :start_time => 11, :end_time => 13, :repeats => 2, :range => '2010-11-10', :age_min => 8, :age_max => 14, :cost => 0, :address1 => '505 Lausen Mall',:city => 'Stanford', :state => 'CA', :zipcode => '94305-3083', :zip_id => 1}])

Repeat.create([{:name => 'Does not repeat'}, {:name => 'Daily'}, {:name => 'Mon-Fri'}, {:name => 'Mon/Wed/Fri'}, {:name => 'Tues/Thurs'}, {:name => 'Weekly'}, {:name => 'Monthly'}, {:name => 'Yearly'}])

Style.create([{:name => 'Drop-in'}, {:name => 'Set schedule'}])

Category.create([{:name => 'Sports'}, {:name => 'Faith-based'}, {:name => 'Academic'}, {:name => 'Youth leadership'}, {:name => 'Community service'}, {:name => 'Enrichment'}, {:name => 'Arts & music'}, {:name => 'Vocational'}, {:name => 'Mentorship'}])
