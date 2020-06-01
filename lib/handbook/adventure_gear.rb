class AdventureGear < Equipment

    def self.create(name, url, description = nil)
        @description = description
        self.new(name, url)
    end

    def fill_attributes(data)
        @equipment_category = data["equipment_category"]
        @gear_category = data["gear_category"]
        @cost = "#{data["cost"]["quantity"]} #{data["cost"]["unit"]}"
        @weight = data["weight"]
        if data.key?("desc")
            @description = data["desc"]
        end

    end

    def print
        puts "\n#{@name}\n\n"
        puts "Equipment Category: #{@equipment_category}\n\n"
        puts "Gear Category: #{@gear_category}\n\n"
        puts "Cost: #{@cost}\n\n"
        puts "Weight: #{@weight}\n\n"
        if @description != nil
            puts "Description: #{@description}\n\n"
        end
    end

end