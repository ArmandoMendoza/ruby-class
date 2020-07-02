class ActiveFile
  attr_accessor :attributes

  def initialize(attributes)
    @attributes = attributes
    @attributes.each do |key, value|
      self.send("#{key.to_s}=", value)
    end
  rescue NoMethodError
    puts "No se encuentra el atributo"
  end

  ## instance methods

  def save
    file = self.class.to_s.downcase
    of = OpenFile.new("#{file}.csv")
    of.add_data(attributes)
  end


  ### class methods

  def self.all
    @data = []
    file = self.to_s.downcase
    raw_data = OpenFile.new("#{file}.csv").fetch_data
    raw_data.each do |d|
      @data << self.new(d)
    end
    @data
  rescue Errno::ENOENT
    puts "No se ha encontrado archivo #{file}.csv"
  end
end