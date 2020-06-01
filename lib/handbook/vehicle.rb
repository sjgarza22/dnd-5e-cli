class Vehicle < Equipment
    def self.create(name, url, description = nil, speed = nil)
        @speed = speed
        @description = description
        self.new(name, url)
    end

    def fill_attributes(data)
        @equipment_category = data["equipment_category"]
        @vehicle_category = data["vehicle_category"]

        if data.key?("speed")
            @speed = "#{data["speed"]["quantity"]} #{data["speed"]["unit"]}"
            @capacity = data["capacity"]
        end

        @cost = "#{data["cost"]["quantity"]} #{data["cost"]["unit"]}"
        @weight = data["weight"]
        if data.key?("desc")
            @description = data["desc"]
        end

    end

    def print
        puts "\n#{@name}\n\n"
        puts "Equipment Category: #{@equipment_category}\n\n"
        puts "Vehicle Category: #{@vehicle_category}\n\n"
        puts "Cost: #{@cost}\n\n"
        puts "Weight: #{@weight}\n\n"
        if @speed != nil
            puts "Speed: #{@speed}\n\n"
            puts "Capacity: #{@capacity}\n\n"
        end
        if @description != nil
            puts "Description: #{@description}\n\n"
        end
    end
end