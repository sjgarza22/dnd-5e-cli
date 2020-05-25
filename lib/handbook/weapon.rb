class Weapon < Equipment
    
    def fill_attributes(data)
        @equipment_category = data["equipment_category"]
        @weapon_category = data["weapon_category"]
        @weapon_range = data["weapon_range"]
        @category_range = data["category_range"]

        if data.key?("damage")
            @damage_dice = data["damage"]["damage_dice"]
            @damage_bonus = data["damage"]["damage_bonus"]
            @damage_type = data["damage"]["damage_type"]["name"]
        end

        @cost = "#{data["cost"]["quantity"]} #{data["cost"]["unit"]}"
        @weight = data["weight"]
        @description = data["desc"]

    end

    def print
        puts "#{@name}\n\n"
        
    end
end