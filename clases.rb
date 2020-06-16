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

  def self.all
    file = self.to_s.downcase
    OpenFile.new("#{file}.csv").fetch_data
  rescue Errno::ENOENT
    puts "No se ha encontrado archivo #{file}.csv"
  end

end

class OpenFile
  attr_accessor :data, :file

  def initialize(file)
    @file = file
    @data = []
  end

  def fetch_data
    n = 0
    headers = []
    File.foreach(file) do |line| 
      if n == 0 
        headers = line.split(",")
      else
        values = line.split(",")
        set_data(headers, values)
      end
      n += 1
    end
    @data
  end

  def add_data(hsh)
  end

  private

  def set_data(headers, values)
    hsh = { }
    headers.each_with_index do |key, index|
      hsh[key.chomp.to_sym] = values[index].chomp
    end
    @data << hsh    
  end

end

class User < Model
  attr_accessor :name, :age, :apellido
end

class Car < Model
  attr_accessor :doors, :year
end

class Person < Model
end

of = OpenFile.new("user.csv")
of.add_data({name: "Mario", age: 50})

user = User.new({name: "Mario", age: 50})
user.save

# BD = [
#   { name: "Armando", age: 40 },
#   { name: "Rodrigo", age: 30 },
#   { name: "Flor",    age: 42 },
#   { name: "Lucia",   age: 15 },
#   { name: "Rafael",  age: 33 },
#   { name: "Javier",  age: 43 }
# ]

# TODO: hacer que find pueda buscar de la siguiente manera
# User.find({nombre: "Armando"}) o User.find({age: 40}) 