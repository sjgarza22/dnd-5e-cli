class PlayerClass
    extend Findable

    attr_reader :name, :attributes_url
    ENDPOINT = "classes"
    @@all = []

    def initialize(name, attributes_url, hit_die = nil, prof_choices_amt = nil, class_levels_url = nil, equipment_url = nil, spellcasting_url = nil)
        @name = name
        @attributes_url = attributes_url
        @hit_die = hit_die
        @prof_choices = []
        @prof_choices_amt = prof_choices_amt
        @proficiencies = []
        @saving_throws = []
        @equipment = []
        @class_levels = []
        @subclasses = []
        @class_levels_url = class_levels_url
        @equipment_url = equipment_url
        @spellcasting_url = spellcasting_url
        @@all << self
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

    def fill_attributes(data)
        @hit_die = data["hit_die"]
        @prof_choices_amt = data["proficiency_choices"][0]["choose"]
        data["proficiency_choices"][0]["from"].each {|skill| @prof_choices << skill["name"]}
        data["proficiencies"].each {|skill| @proficiencies << skill["name"]}
        data["saving_throws"].each {|skill| @saving_throws << skill["name"]}
        @equipment_url = data["starting_equipment"]["url"]
        @class_levels_url = data["class_levels"]["url"]
        data["subclasses"].each {|subclass| @subclasses << subclass["name"]}
        if data.key?("spellcasting")
            @spellcasting_url = data["spellcasting"]["url"]
        end
    end

    def print
        puts "#{@name}\n\n"
        puts "Hit Die: #{@hit_die}\n\n"
        puts "Proficiency Choices Amount: #{@prof_choices_amt}\n\n"
        puts "Proficiency Choices: "
        @prof_choices.each {|proficiency| puts "#{proficiency}"}
        puts "\nSaving Throws: "
        @saving_throws.each {|saving_throw| puts "#{saving_throw}"}
        puts "\nSubclasses: "
        @subclasses.each {|subclass| puts "#{subclass}"}
    end

    def self.create(name, url)
        self.new(name, url)
    end
end