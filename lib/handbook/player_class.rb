class PlayerClass

    @@all = []

    def initialize(name, hit_die, proficiency_choices, proficiency_num)

        save
    end

    def self.save
        @@all << self
    end
end