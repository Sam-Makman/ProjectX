# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

UnregisteredDevice.create(device_id: "1234", unique_id: "abc")
UnregisteredDevice.create(device_id: "123", unique_id: "abcd")
UnregisteredDevice.create(device_id: "12", unique_id: "abcz")
