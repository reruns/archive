# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
Cat.create!(name: 'Sennacy', birth_date: Date.yesterday, color: 'orange', sex: 'M', description: 'a mystery')
Cat.create!(name: 'Sherriff', birth_date: Date.today, color: 'calico', sex: 'F', description: 'sat on day9s lap while he lost at hearthstone')
Cat.create!(name: 'Sophie', birth_date: Date.today, color: 'white', sex: 'F', description: 'also a cat')
