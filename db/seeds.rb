# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)
#Repeat.create([{:name => 'Does not repeat'}, {:name => 'Daily'}, {:name => 'Mon-Fri'}, {:name => 'Mon/Wed/Fri'}, {:name => 'Tues/Thurs'}, {:name => 'Weekly'}, {:name => 'Monthly'}, {:name => 'Yearly'}])

#Style.create([{:name => 'Drop-in'}, {:name => 'Set schedule'}])

#Category.create([{:name => 'Sports'}, {:name => 'Faith-based'}, {:name => 'Academic'}, {:name => 'Youth leadership'}, {:name => 'Community service'}, {:name => 'Enrichment'}, {:name => 'Arts & music'}, {:name => 'Vocational'}, {:name => 'Mentorship'}])

service_groups = ServiceGroup.create([{:name=> 'Project WeHOPE',:address1=> '1858-B Bay Road',:address2=> '',:city=> 'East Palo Alto',:state=> 'CA',:zip=> '94303',:phone=> '',:website=> 'http://www.projectwehope.org/',:inception_date=> ''}])
service_group = ServiceGroup.create([{:name=> 'Bayshore Christian Ministries',:address1=> '1001 Beech Street',:address2=> '',:city=> 'East Palo Alto',:state=> 'CA',:zip=> '94303',:phone=> '(650) 327-1139',:website=> 'www.bayshore.org/',:inception_date=> ''}])
service_group = ServiceGroup.create([{:name=> 'St. Francis Church',:address1=> '1425 Bay Rd.',:address2=> '',:city=> 'East Palo Alto',:state=> 'CA',:zip=> '94303',:phone=> '(650) 322-2365',:website=> 'http://www.stfrancisyouthclub.org/',:inception_date=> ''}])
service_group = ServiceGroup.create([{:name=> 'EPA Youth Court',:address1=> 'P.O. Box 50878',:address2=> '',:city=> 'East Palo Alto',:state=> 'CA',:zip=> '94303',:phone=> '',:website=> 'http://www.epayouthcourt.org/',:inception_date=> ''}])
service_group = ServiceGroup.create([{:name=> 'Peninsula Conflict Resolution Center',:address1=> '1660 S. Amphlett Blvd.',:address2=> '#219',:city=> 'San Mateo',:state=> 'CA',:zip=> '94402',:phone=> '650-513-0330',:website=> 'http://www.pcrcweb.org/',:inception_date=> ''}])
service_group = ServiceGroup.create([{:name=> 'Mural Music and Arts Project',:address1=> '2043 Euclid Ave',:address2=> '',:city=> 'East Palo Alto',:state=> 'CA',:zip=> '94303',:phone=> '(650) 520-8061',:website=> 'http://www.muralmusicarts.org',:inception_date=> ''}])
service_group = ServiceGroup.create([{:name=> 'Ravenswood Family Health Center',:address1=> '1798A Bay Road',:address2=> '',:city=> 'East Palo Alto',:state=> 'CA',:zip=> '94303',:phone=> '(650) 330-7400',:website=> 'http://www.ravenswoodfhc.org/',:inception_date=> ''}])
service_group = ServiceGroup.create([{:name=> 'Onetta Harris Center',:address1=> '100 Terminal Ave',:address2=> '',:city=> 'Menlo Park',:state=> 'CA',:zip=> '94025',:phone=> '650.330.2250',:website=> 'http://www.menlopark.org/departments/com/ohcc.html',:inception_date=> ''}])
service_group = ServiceGroup.create([{:name=> 'Built to Last',:address1=> '100 Terminal Ave',:address2=> '',:city=> 'Menlo Park',:state=> 'CA',:zip=> '94025',:phone=> '',:website=> '',:inception_date=> ''}])
service_group = ServiceGroup.create([{:name=> 'Senior Center',:address1=> '',:address2=> '',:city=> '',:state=> '',:zip=> '',:phone=> '',:website=> '',:inception_date=> ''}])
service_group = ServiceGroup.create([{:name=> 'Haas Center',:address1=> '562 Salvatierra Walk',:address2=> '',:city=> 'Stanford',:state=> 'CA',:zip=> '94305',:phone=> '(650) 723-0992',:website=> 'http://studentaffairs.stanford.edu/haas',:inception_date=> ''}])
service_group = ServiceGroup.create([{:name=> 'EPA Phoenix Academy',:address1=> '1848C Bay Road',:address2=> '',:city=> 'East Palo Alto',:state=> 'CA',:zip=> '94303',:phone=> '(650) 325-1460',:website=> 'http://www.epapa.org/',:inception_date=> ''}])
service_group = ServiceGroup.create([{:name=> 'Boys and Girls Club',:address1=> '401 Pierce Road',:address2=> '',:city=> 'Menlo Park',:state=> 'CA',:zip=> '94025',:phone=> '(650) 646-6140',:website=> 'http://www.bgcp.org/',:inception_date=> ''}])
service_group = ServiceGroup.create([{:name=> 'Youth Community Service',:address1=> '4120 Middlefield Rd.',:address2=> 'Room P-8',:city=> 'Palo Alto',:state=> 'CA',:zip=> '94303',:phone=> '650.858.8021',:website=> 'http://www.youthcommunityservice.org',:inception_date=> ''}])
service_group = ServiceGroup.create([{:name=> 'Big Brothers/Big Sisters',:address1=> '731 Market Street',:address2=> '6th Floor',:city=> 'San Francisco',:state=> 'CA',:zip=> '94103',:phone=> '(415) 503-4050',:website=> 'http://www.bbbsba.org',:inception_date=> ''}])
service_group = ServiceGroup.create([{:name=> 'EPA Charter School',:address1=> '1286 Runnymede Street',:address2=> '',:city=> 'East Palo Alto',:state=> 'CA',:zip=> '94303',:phone=> '(650) 614-9100',:website=> 'http://www.epacs.org/',:inception_date=> ''}])
service_group = ServiceGroup.create([{:name=> 'Girls on the Run',:address1=> '3543 18th Street #31 ',:address2=> '',:city=> 'San Francisco',:state=> 'CA',:zip=> '94110',:phone=> '415.863.8942 ',:website=> 'http://www.gotrbayarea.org',:inception_date=> ''}])
service_group = ServiceGroup.create([{:name=> 'Girls for a Change',:address1=> '',:address2=> '',:city=> '',:state=> '',:zip=> '',:phone=> '408.529.9304',:website=> 'http://girlsforachange.typepad.com/national/2007/04/silicon_valley.html',:inception_date=> ''}])
service_group = ServiceGroup.create([{:name=> 'Science Bus',:address1=> '',:address2=> '',:city=> '',:state=> '',:zip=> '',:phone=> '',:website=> 'http://www.stanford.edu/group/sciencebus/',:inception_date=> ''}])
service_group = ServiceGroup.create([{:name=> 'For Youth By Youth',:address1=> '',:address2=> '',:city=> '',:state=> '',:zip=> '',:phone=> '(510) 772-8917',:website=> 'http://www.fyby.org',:inception_date=> ''}])
service_group = ServiceGroup.create([{:name=> 'Belle Haven Community School',:address1=> '415 Ivy Drive',:address2=> '',:city=> 'Menlo Park',:state=> 'CA',:zip=> '94025',:phone=> '(650) 329-2898',:website=> '',:inception_date=> ''}])
service_group = ServiceGroup.create([{:name=> 'Computers for Everyone',:address1=> '3723 Haven  Avenue',:address2=> '',:city=> 'Menlo Park',:state=> 'CA',:zip=> '94025',:phone=> '(650) 847-5708',:website=> 'http://www.computersforeveryone.biz',:inception_date=> ''}])
service_group = ServiceGroup.create([{:name=> 'Club IMPACT',:address1=> '',:address2=> '',:city=> '',:state=> '',:zip=> '',:phone=> '',:website=> '',:inception_date=> ''}])
service_group = ServiceGroup.create([{:name=> 'YMCA',:address1=> '550 Bell Street ',:address2=> '',:city=> 'East Palo Alto',:state=> 'CA',:zip=> '94303',:phone=> '(650) 328.9622',:website=> 'http://www.ymcasv.org/eastpaloalto/',:inception_date=> ''}])
service_group = ServiceGroup.create([{:name=> 'East Palo Alto Library',:address1=> '2415 University Avenue',:address2=> '',:city=> 'East Palo Alto',:state=> 'CA',:zip=> '94303',:phone=> '650.321.7712',:website=> 'http://www.smcl.org',:inception_date=> ''}])
service_group = ServiceGroup.create([{:name=> 'Foundation for a College Education',:address1=> '2160 Euclid Avenue',:address2=> '',:city=> 'East Palo Alto',:state=> 'CA',:zip=> '94303',:phone=> '650.322.5048',:website=> 'http://www.collegefoundation.org',:inception_date=> ''}])
service_group = ServiceGroup.create([{:name=> 'Cleo Eulau Center',:address1=> '2483 Old Middlefield Way',:address2=> ' Suite 208',:city=> 'Mountain View',:state=> 'CA',:zip=> '94043',:phone=> '(650) 314-0180',:website=> 'http://cleoeulaucenter.org/',:inception_date=> ''}])
service_group = ServiceGroup.create([{:name=> 'Sequoia Union High School District',:address1=> '480 James Ave',:address2=> '',:city=> 'Redwood City',:state=> 'CA',:zip=> '94062',:phone=> '(650) 369-1411',:website=> 'http://www.sequoiadistrict.org/',:inception_date=> ''}])
service_group = ServiceGroup.create([{:name=> 'Peninsula Interfaith Action',:address1=> '1336 Arroyo Avenue',:address2=> '',:city=> 'San Carlos',:state=> 'CA',:zip=> '94070',:phone=> '650.592.9181',:website=> 'http://www.piapico.org/',:inception_date=> ''}])
service_group = ServiceGroup.create([{:name=> 'Kiwanis Club',:address1=> '570 S Rengstorff Ave #54',:address2=> '',:city=> 'Mountain View',:state=> 'CA',:zip=> '94040',:phone=> '650-853-3100',:website=> 'http://bayshorecommunitykiwanisclub.thewebsecretary.net/',:inception_date=> ''}])
service_group = ServiceGroup.create([{:name=> 'City of East Palo Alto',:address1=> '2277 University Avenue',:address2=> '',:city=> 'East Palo Alto',:state=> 'CA',:zip=> '94303',:phone=> '650-853-3139',:website=> 'http://www.ci.east-palo-alto.ca.us/community/index.htm',:inception_date=> ''}])
service_group = ServiceGroup.create([{:name=> 'East Palo Alto Tennis and Tutoring',:address1=> '625 Campus Dr',:address2=> '',:city=> 'Stanford',:state=> 'CA',:zip=> '94305',:phone=> '650 725 4450',:website=> 'http://epatt.org',:inception_date=> ''}])
service_group = ServiceGroup.create([{:name=> 'Youth United for Community Action',:address1=> '2135 Clarke Avenue',:address2=> '',:city=> 'East Palo Alto',:state=> 'CA',:zip=> '94303',:phone=> '(650)322-9165',:website=> 'http://www.youthunited.net',:inception_date=> ''}])
service_group = ServiceGroup.create([{:name=> 'San Mateo County Health Department',:address1=> '',:address2=> '',:city=> '',:state=> '',:zip=> '',:phone=> '(888) 840-0889',:website=> 'http://www.co.sanmateo.ca.us/portal/site/health',:inception_date=> ''}])
service_group = ServiceGroup.create([{:name=> 'Eastside Prep',:address1=> '1041 Myrtle Street',:address2=> '',:city=> 'East Palo Alto',:state=> 'CA',:zip=> '94303',:phone=> '(650) 688-0850',:website=> 'www.eastside.org/',:inception_date=> ''}])
service_group = ServiceGroup.create([{:name=> 'Business United in Investing, Lending and Developing (BUILD)',:address1=> '2197 East Bayshore Road',:address2=> '',:city=> 'Palo Alto',:state=> 'CA',:zip=> '94303',:phone=> '650.543.4762',:website=> 'http://www.build.org/',:inception_date=> ''}
])

#service_groups = ServiceGroup.create([{ :name => 'John Gardner Center', :address1 => '505 Lausen Mall',:city => 'Stanford', :state => 'CA', :zip => '94305-3083', :phone => '650.723.1137', :inception_date => '2000-09-01'},{:name => 'YDA at the John Gardner Center', :address1 => '505 Lausen Mall',:city => 'Stanford', :state => 'CA', :zip => '94305-3083', :phone => '650.723.1137', :inception_date => '2000-09-01'}])  

#ServicePerson.create([{ :service_group_id => service_groups[0].id, :first_name => 'Laura',:last_name => 'Ma', :email => 'nowhere@nowhere.com', :phone => '650.723.3682'},{:service_group_id => service_groups[0].id, :first_name => 'Amy',:last_name => 'Gerstein', :email => 'nowhere@nowhere.com', :phone => '650.723.3682'}])  

#Zip.create([{:code => '94305-3083', :city => 'Stanford', :state => 'CA', :lat => 37.426394, :lon => -122.173745}])

#Program.create([{:service_group_id => 1, :name => 'soccer', :description => 'running around in packs', :start_date => '2010-07-01', :end_date => '2010-07-01', :start_time => 16, :end_time => 20, :repeats => 1, :range => '2010-07-01', :age_min => 8, :age_max => 14, :cost => 0, :address1 => '505 Lausen Mall',:city => 'Stanford', :state => 'CA', :zipcode => '94305-3083'},{:service_group_id => 1, :name => 'Arts and crafts', :description => 'paints and drawing', :start_date => '2010-07-08', :end_date => '2010-07-08', :start_time => 11, :end_time => 13, :repeats => 2, :range => '2010-11-10', :age_min => 8, :age_max => 14, :cost => 0, :address1 => '505 Lausen Mall',:city => 'Stanford', :state => 'CA', :zipcode => '94305-3083'}])

