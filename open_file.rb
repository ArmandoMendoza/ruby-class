class OpenFile
  attr_accessor :data, :file

  def initialize(file)
    @file = file
    @headers = []
  end

  def headers
    @headers.map(&:chomp).map(&:to_sym)
  end

  def fetch_data
    n = 0
    @data = []
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

    return if hsh_exists?(hsh)
    
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

  def hsh_exists?(hsh)
    #TODO: ver si en @data existe hsh y retornar true si existe.
  end

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