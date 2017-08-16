# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

[
  {
    name: 'Session 9.9 DH 27.5 Race Shop Limited',
    description: 'World Cup champion Session is built to win. An all-new OCLV Carbon frame, updated geometry, advanced air shock, and a stiffer chassis make this downhill race bike faster than ever.

Session is the DH bike that excels on downhill\'s most brutal courses. Take on any terrain with our most advanced suspension and a geometry that can be dialed for every race.',
    image_url: 'https://trek.scene7.com/is/image/TrekBicycleProducts/1176800_2017_A_1_Session_99_DH?wid=1200&hei=900&fmt=jpg&qlt=50',
    colour: 'Red',
    price: 7_500
  },
  {
    name: 'Powerfly 7 FS Plus',
    description: 'Powerfly eMTB builds on its success with a new full suspension lineup that borrows from Trek’s proven off-road legacy.

The full suspension Powerfly makes mountain biking even more fun. The Bosch Performance CX pedal assist e-bike system makes for a supremely capable electric bike that allows you to go farther and have more fun.',
    image_url: 'https://trek.scene7.com/is/image/TrekBicycleProducts/2932700_2018_A_1_Powerfly_FS_7?wid=1200&hei=900&fmt=jpg&qlt=50',
    colour: 'Black',
    price: 2_900
  },
  {
    name: 'CrossRip 2',
    description: 'The drop-bar CrossRip is surefooted when roads get rough, quick in traffic, and comfortable over the long haul. Commuter? Gravel grinder? Café racer?

CrossRip pairs the efficiency of a road bike with the go-anywhere durability of something more. It\'s the one bike that takes you from your workday commute right into your weekend adventure.',
    image_url: 'https://trek.scene7.com/is/image/TrekBicycleProducts/1376000_2017_A_1_CrossRip_2?wid=1200&hei=900&fmt=jpg&qlt=50',
    colour: 'Metallic Charcoal',
    price: 800
  },
  {
    name: 'Zektor i3',
    description: 'Zektor is a new way to move through cities and urban areas. It\'s just as practical as a standard commuter, but more aggressive for a faster, more engaging ride.

It\'s not enough to get from A to B. Zektor\'s agile, responsive ride feel and all-weather build bring a heavy dose of excitement to your daily commute.',
    image_url: 'https://trek.scene7.com/is/image/TrekBicycleProducts/1364000_2017_A_1_ZEKTOR_i3?wid=1200&hei=900&fmt=jpg&qlt=50',
    colour: 'Metallic Charcoal',
    price: 750
  }
].each { |product| Product.create!(product) }
