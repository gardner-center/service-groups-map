LATLON_DELTA = 2
HOME_ZIP = "94303"
HOME_LAT = 37.455641
HOME_LON = -122.131902
DEFAULT_RADIUS = 15
REPEATS = Repeat.all #Fails if DB not initializd
REPEATS_HASH = {}
for repeat in REPEATS
  REPEATS_HASH[repeat[:id]] = repeat[:name]
end
CATEGORIES = Category.all  #Fails if DB not initialized
CATEGORIES_HASH = {}
for category in CATEGORIES
  CATEGORIES_HASH[category[:id]] = category[:name]
end
STYLES = Style.all  #Fails if DB not initialized
STYLES_HASH = {}
for style in STYLES
  STYLES_HASH[style[:id]] = style[:name]
end
STATES = {
  :AK => "Alaska",
  :AL => "Alabama",
  :AZ => "Arizona",
  :AR => "Arkansas",
  :CA => "California",
  :CO => "Colorado",
  :CT => "Connecticut",
  :DE => "Delaware",
  :DC => "District Of Columbia",
  :FL => "Florida",
  :GA => "Georgia",
  :HI => "Hawaii",
  :ID => "Idaho",
  :IL => "Illinois",
  :IN => "Indiana",
  :IA => "Iowa",
  :KS => "Kansas",
  :KY => "Kentucky",
  :LA => "Louisiana",
  :ME => "Maine",
  :MD => "Maryland",
  :MA => "Massachusetts",
  :MI => "Michigan",
  :MN => "Minnesota",
  :MS => "Mississippi",
  :MO => "Missouri",
  :MT => "Montana",
  :NE => "Nebraska",
  :NV => "Nevada",
  :NH => "New Hampshire",
  :NJ => "New Jersey",
  :NM => "New Mexico",
  :NY => "New York",
  :NC => "North Carolina",
  :ND => "North Dakota",
  :OH => "Ohio",
  :OK => "Oklahoma",
  :OR => "Oregon",
  :PA => "Pennsylvania",
  :PR => "Puerto Rico",
  :RI => "Rhode Island",
  :SC => "South Carolina",
  :SD => "South Dakota",
  :TN => "Tennessee",
  :TX => "Texas",
  :UT => "Utah",
  :VT => "Vermont",
  :VI => "Virgin Islands",
  :VA => "Virginia",
  :WA => "Washington",
  :WV => "West Virginia",
  :WI => "Wisconsin",
  :WY => "Wyoming"
}
