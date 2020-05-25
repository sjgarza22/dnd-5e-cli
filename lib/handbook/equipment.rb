class Equipment
    extend Concerns::Findable

    attr_reader :name, :url
    ENDPOINT = "equipment"
    @@all = []

    def initialize(name, url, equipment_category = nil)
        @name = name
        @url = url
        @equipment_category = equipment_category
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
end