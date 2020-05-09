class Spell
    attr_reader :name
    ENDPOINT = "spells"
    @@all = []

    def initialize(name)
        @name = name
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