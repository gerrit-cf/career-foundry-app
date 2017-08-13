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
    image_url: 'https://trek.scene7.com/is/image/TrekBicycleProducts/1176800_2017_A_1_Session_99_DH?wid=1200&hei=1000&fmt=jpg,rgb',
    color: 'Red'
  },
  {
    name: 'Powerfly 7 FS Plus',
    description: 'Powerfly eMTB builds on its success with a new full suspension lineup that borrows from Trek’s proven off-road legacy.

The full suspension Powerfly makes mountain biking even more fun. The Bosch Performance CX pedal assist e-bike system makes for a supremely capable electric bike that allows you to go farther and have more fun.',
    image_url: 'https://trek.scene7.com/is/image/TrekBicycleProducts/2932700_2018_A_1_Powerfly_FS_7?wid=1200&hei=1000&fmt=jpg,rgb',
    color: 'Black'
  }
].each { |product| Product.create!(product) }
