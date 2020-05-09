class PlayerClass
    @attr_accessor :hit_die
    @attr_reader :name
    ENDPOINT = "classes"
    @@all = []

    def initialize(name, hit_die, prof_choices, prof_choices_amt, proficiencies, saving_throws, equipment, class_levels, subclasses, spellcasting)
        @name = name
        save
    end

    def self.save
        @@all << self
    end

    def self.all
        @@all
    end

    def self.endpoint
        ENDPOINT
    end

    def find_by_name(name)
        self.all.find {|spell| spell.name == name}
    end

    def find_or_create_by_name(name)
        if !(find_by_name(name))
            create(name)
        else
            find_by_name(name)
        end
    end
end