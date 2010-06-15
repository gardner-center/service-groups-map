# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)

service_group = ServiceGroup.create( :name => 'John Gardner Center', :address1 => '505 Lausen Mall',:city => 'Stanford', :state => 'CA', :zip => '94305-3083', :phone => '650.723.1137', :inception_date => '2000-09-01') 

ServicePerson.create( :service_group_id => service_group.id, :first_name => 'Laura',:last_name => 'Ma', :email => 'nowhere@nowhere.com', :phone => '650.723.3682') 

Program.create(:name => 'soccer', :description => 'running around in packs', :start_date => '2010-07-01', :end_date => '2010-07-01', :start_time => 16, :end_time => 20, :repeats => 0, :range => '2010-07-01', :age_min => 8, :age_max => 14, :cost => 0, :address1 => '505 Lausen Mall',:city => 'Stanford', :state => 'CA', :zip => '94305-3083')

Repeat.create([{:name => 'Does not repeat'}, {:name => 'Daily'}, {:name => 'Mon-Fri'}, {:name => 'Mon/Wed/Fri'}, {:name => 'Tues/Thurs'}, {:name => 'Weekly'}, {:name => 'Monthly'}, {:name => 'Yearly'}])

Style.create([{:name => 'Drop-in'}, {:name => 'Set schedule'}])

Category.create([{:name => 'Sports'}, {:name => 'Faith-based'}, {:name => 'Academic'}, {:name => 'youth leadership'}, {:name => 'Community service'}, {:name => 'Enrichment'}, {:name => 'Arts & music'}, {:name => 'Vocational'}, {:name => 'Mentorship'}])
