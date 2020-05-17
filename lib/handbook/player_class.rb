class PlayerClass
    attr_accessor :hit_die, :prof_coices, :prof_choices_amt, :proficiencies, :saving_throws, :equipment, :class_levels, :subclasses, :spellcasting
    attr_reader :name
    ENDPOINT = "classes"
    @@all = []

    def initialize(name)
        @name = name
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

    def self.find_by_name(name)
        self.all.find {|player_class| player_class.name == name}
    end

    def self.find_or_create_by_name(name)
        if !(find_by_name(name))
            PlayerClass.new(name)
        else
            find_by_name(name)
        end
    end
end