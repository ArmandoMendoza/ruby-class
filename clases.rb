require_relative 'active_file'
require_relative 'open_file'

class User < ActiveFile
  attr_accessor :name, :age

  def attributes
    { name: @name, age: @age }
  end
end

class Car < ActiveFile
  attr_accessor :model, :year, :color

  def attributes
    { model: @model, color: @color, year: @year }
  end
end

puts "IMPLEMENTANDO solo OpenFile"

of = OpenFile.new("user.csv")
puts of.fetch_data

puts "----"

of.add_data({name: "Mario1", age: 70})

puts of.fetch_data


puts "IMPLEMENTANDO OpenFile en ActiveFile"

User.all.each { |u| puts u.inspect }

puts "----"

mario = User.new({name: "Mario2", age: 70})
mario.age = 80
mario.save

User.all.each { |u| puts u.inspect }




# armando = users.first
# puts armando.attributes
# armando.name = "Francisco Armando"
# puts armando.attributes
# puts armando.save