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
    @headers = []
  end

  def headers
    @headers.map(&:chomp).map(&:to_sym)
  end

  def fetch_data
    n = 0
    File.foreach(file) do |line| 
      if n == 0 
        @headers = line.split(",")
      else
        values = line.split(",")
        set_data(headers, values)
      end
      n += 1
    end
    data
  end

  def add_data(hsh)
    fetch_data
    
    hsh.keys.each do |key| 
      unless headers.include?(key)
        raise "Hash invalido: Llave #{key} +"
      end
    end

    values = []
    headers.each do |key|
      values << hsh.fetch(key, "")
    end
    
    string = values.join(",")

    write(string)
  end

  private

  def write(string)
    File.open(file, "a") do |f|
      f.puts string
    end
  end

  def set_data(headers, values)
    hsh = { }
    headers.each_with_index do |key, index|
      hsh[key] = values[index].chomp
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

hsh = {age: 50, name: "Mario"}
puts of.add_data(hsh)

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