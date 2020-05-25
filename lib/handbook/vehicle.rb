class Vehicle < Equipment

    def fill_attributes(data)
        @equipment_category = data["equipment_category"]
        @vehicle_category = data["vehicle_category"]

        if data.key?("speed")
            @speed = "#{data["speed"]["quantity"]} #{data["speed"]["unit"]}"
            @capacity = data["capacity"]
        end

        @cost = "#{data["cost"]["quantity"]} #{data["cost"]["unit"]}"
        @weight = data["weight"]
        @description = data["desc"]

    end

    def print
        puts "#{@name}\n\n"
        puts "Speed: "
    end
end