class Race
    extend Findable

    ENDPOINT = "races"
    attr_reader :name, :url
    @@all = []

    def initialize(name, url, speed = nil, alignment = nil, age = nil, size = nil, size_description = nil, language_desc = nil,
        trait_options_choice = nil)
        @name = name
        @url = url
        @speed = speed
        @ability_bonuses = []
        @alignment = alignment
        @age = age
        @size = size
        @size_description = size_description
        @starting_proficiencies = []
        @languages = []
        @language_desc = language_desc
        @traits = []
        @trait_options = []
        @trait_options_choice = trait_options_choice
        @subraces = []
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
        @speed = data["speed"]
        data["ability_bonuses"].each {|ability| @ability_bonuses << {"name" => ability["name"], "bonus" => ability["bonus"]}}
        # Add ability bonus options & amt
        @alignment = data["alignment"]
        @age = data["age"]
        @size = data["size"]
        @size_description = data["size_description"]
        @starting_proficiencies = data["starting_proficiencies"]
        data["languages"].each {|language| @languages << language["name"]}
        @language_desc = data["language_desc"]
        # Add language choice options & amt
        data["traits"].each {|trait| @traits << trait["name"]}
        if data.key?("trait_options")
            @trait_options_choice = data["trait_options"]["choose"]
            data["trait_options"]["from"].each {|trait_option| @trait_options << trait_option["name"]}
        end
    end

    def print
        puts "#{@name}\n\n"
        puts "Speed: #{@speed}\n\n"
        puts "Ability Bonuses:"
        @ability_bonuses.each {|ability| puts "#{ability["name"]}\nBonus: #{ability["bonus"]}"}
        puts "\nAlignment: #{@alignment}"
        puts "\nAge: #{@age}"
        puts "\nSize: #{@size}"
        puts "\nSize Description: #{@size_description}"
        puts "\nLanguages: "
        @languages.each {|language| puts "#{language}"}
        puts "\nLanguage Description: #{@language_desc}"
        puts "\nTraits: "
        @traits.each {|trait| puts "#{trait}"}
        if @trait_options != []
            puts "\nTrait Options Choose: #{@trait_options_choice}"
            puts "Trait Options:"
            @trait_options.each {|trait_option| puts trait_option}
        end
    end

    def self.create(name, url)
        self.new(name, url)
    end
end