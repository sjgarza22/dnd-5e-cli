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

    def self.create(name, url, higher_level = nil, material = nil)
        @material = material
        @higher_level = higher_level
        new_spell = self.new(name, url)
        data = Api.load_attributes(url)
        new_spell.fill_attributes(data)
        new_spell
    end

    def fill_attributes(data)
        @description = data["desc"]
        if data.key?("higher_level")
            @higher_level = data["higher_level"]
        end
        @range = data["range"]
        @components = []
        data["components"].each {|component| @components << component}
        if data.key?("material")
            @material = data["material"]
        end
        @ritual = data["ritual"]
        @duration = data["duration"]
        @concentration = data["concentration"]
        @casting_time = data["casting_time"]
        @level = data["level"]
        @school = data["school"]["name"]
        @classes = []
        @subclasses = []
        data["classes"].each {|spell_class| @classes << spell_class["name"]}
        data["subclasses"].each {|subclass| @subclasses << subclass["name"]}
    end

    def print
        puts "\n#{@name}\n\n"
        puts "Description: #{@description}\n\n"
        if @higher_level != nil
            puts "Higher Level: #{@higher_level}\n\n"
        end
        puts "Range: #{@range}\n\n"
        puts "Components:"
        @components.each {|component| puts component}
        if @material != nil
            puts "\nMaterial: #{@material}\n\n"
        end
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