class Equipment
    extend Findable

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
            equip = Weapon.new(name, url)
            @@all << equip
            equip.fill_attributes(data)
            equip
        when "Mounts and Vehicles"
            equip = Vehicle.create(name, url)
            @@all << equip
            equip.fill_attributes(data)
            equip
        when "Adventuring Gear"
            equip = AdventureGear.create(name, url)
            @@all << equip
            equip.fill_attributes(data)
            equip
            
        when "Tools"
            equip = Tool.create(name, url)
            @@all << equip
            equip.fill_attributes(data)
            equip
        when "Armor"
            equip = Armor.create(name, url)
            @@all << equip
            equip.fill_attributes(data)
            equip
        end
    end
end