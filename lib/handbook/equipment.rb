class Equipment
    extend Concerns::Findable

    attr_reader :name, :url
    ENDPOINT = "equipment"
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

    def self.create(name, url)
        data = Api.load_attributes(url)

        case data["equipment_category"]
        when "Weapon"
            Weapon.new(name, url).fill_attributes(data)
        when "Mounts and Vehicles"
            Vehicle.create(name, url).fill_attributes(data)
        when "Adventuring Gear"
            AdventureGear.create(name, url).fill_attributes(data)
        when "Tools"
            Tool.create(name, url).fill_attributes(data)
        when "Armor"
            Armor.create(name, url).fill_attributes(data)
        else
            puts "Error"
        end
    end
end