class Spell
    extend Findable

    attr_reader :name, :url
    ENDPOINT = "spells"
    @@all = []

    def initialize(name, url)
        @name = name
        @url = url
        save
    end

    def save
        @@all << self
    end

    def self.all
        @@all
    end

    def self.endpoint
        ENDPOINT
    end

    def self.create(name, url, higher_level = nil)
        @higher_level = higher_level
        @components = []
        @classes = []
        @subclasses = []
        self.new(name, url)
    end

    def fill_attributes(data)
        @description = data["desc"]
        if data.key?("higher_level")
            @higher_level = data["higher_level"]
        end
        @range = data["range"]
        data["components"].each {|component| @components << component}
        @material = data["material"]
        @ritual = data["ritual"]
        @duration = data["duration"]
        @concentration = data["concentration"]
        @casting_time = data["casting_time"]
        @level = data["level"]
        @school = data["school"]["name"]
        data["classes"].each {|spell_class| @classes << spell_class["name"]}
        data["subclasses"].each {|subclass| @subclasses << subclass["name"]}
    end

    def print
        puts "#{@name}\n\n"
        puts "Description: #{@description}\n\n"
        if @higher_level != nil
            puts "Higher Level: #{@higher_level}\n\n"
        end
        puts "Range: #{@range}\n\n"
        puts "Components:"
        @components.each {|component| puts component}
        puts "\nMaterial: #{@material}\n\n"
        puts "Ritual: #{@ritual}\n\n"
        puts "Duration: #{@duration}\n\n"
        puts "Concentration: #{@concentration}\n\n"
        puts "Casting Time: #{@casting_time}\n\n"
        puts "Level: #{@level}\n\n"
        puts "School: #{@school}\n\n"
        puts "Classes:"
        @classes.each {|spell_class| puts spell_class}
        puts "\nSubclasses:"
        @subclasses.each {|subclass| puts subclass}
        puts " "
    end
end