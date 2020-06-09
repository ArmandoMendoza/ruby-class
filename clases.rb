class Model
  attr_accessor :attributes

  def initialize(attributes)
    @attributes = attributes
    @attributes.each do |key, value|
      self.send("#{key.to_s}=", value)
    end
  rescue NoMethodError
    puts "No se encuentra el atributo"
  end

  def save
    "guardando en BD #{@name}, #{@age}"
  end

  def self.all
    records = []
    BD.each do |data|
      records.push new(data[:name], data[:age])
    end
    records 
  end

  def self.find(name)
    records = []
    array = BD.select {|data| data[:name] == name }
    array.each do |data|
      records.push new(data[:name], data[:age])
    end
    records
  end

end

class User < Model
  attr_accessor :name, :age, :apellido
end

class Car < Model
  attr_accessor :doors, :year
end





BD = [
  { name: "Armando", age: 40 },
  { name: "Rodrigo", age: 30 },
  { name: "Flor",    age: 42 },
  { name: "Lucia",   age: 15 },
  { name: "Rafael",  age: 33 },
  { name: "Javier",  age: 43 }
]

# TODO: hacer que find pueda buscar de la siguiente manera
# User.find({nombre: "Armando"}) o User.find({age: 40}) 