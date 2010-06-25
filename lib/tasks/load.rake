namespace :load do

  ZIP_CODE_DATA_URL = 'http://www.census.gov/tiger/tms/gazetteer/zips.txt'

  # Swiped from ActiveRecord migrations.rb
  def announce(message)
    length = [0, 75 - message.length].max
    puts "== %s %s" % [message, "=" * length]
  end

  desc "Loads zip codes from #{ZIP_CODE_DATA_URL}"
  task :zip_codes => :environment do
    begin
      time = Benchmark.measure do      
				require 'open-uri'
				zips = open(ZIP_CODE_DATA_URL).read
				lines = zips.split("\n")				
				for line in lines
					info = line.split(",")
				  zip = Zip.create!(
            :code => info[1][1,info[1].size-2],
            :state => info[2][1,info[2].size-2],
            :city => info[3][1,info[3].size-2],
            :lat => info[4],
            :lon => info[5])
        end
      end
      announce "Loaded %5d zip codes in (%2dm %2.0fs)" % [Zip.count, *time.real.divmod(60)]
    rescue LoadError
      puts "This rake task requires fastercsv.  To install, run this command:\n\n  sudo gem install fastercsv\n\n"
    end
  end

  desc "Creates n number random users using the Random Data gem, defaults to 1000"
  task :random_users, :n, :needs => :environment do |t, args|
    begin
      n = args.n.to_i < 1 ? 1000 : args.n.to_i
      time = Benchmark.measure do      
        require 'random_data' 
        domains = %w[yahoo.com gmail.com privacy.net webmail.com msn.com hotmail.com example.com privacy.net]
        zips = Zip.all #Can we fit 29k zip codes into memory?
        n.times do |i|
          user = User.new(:first_name => Random.firstname, :last_name => Random.lastname)
          user.username = "#{user.first_name[0,1]}#{user.last_name}#{i}".downcase
          user.password = user.password_confirmation = "secret"
          user.email = "#{user.username}\@#{domains.rand}"
          user.address = Random.address_line_1
          zip = zips.rand
          user.city = zip.city.titleize
          user.state = zip.state
          user.zip = zip
          user.save!
          puts "%6d: %15s %15s, %30s, %20s, %2s, %5s" % [(i+1), user.first_name, user.last_name, user.email, user.city, user.state, user.zip.code]
        end
      end
      announce "Loaded %6d users in (%2dm %2.0fs)" % [n, *time.real.divmod(60)]      
    rescue LoadError
      puts "This rake task requires random_data.  To install, run this command:\n\n  sudo gem install random_data\n\n"
    end      
  end

end
