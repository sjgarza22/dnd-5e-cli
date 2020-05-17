class Race
    ENDPOINT = "races"
    attr_reader :name
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
        self.all.find {|race| race.name == name}
    end

    def self.find_or_create_by_name(name)
        if !(find_by_name(name))
            Race.new(name)
        else
            find_by_name(name)
        end
    end
end