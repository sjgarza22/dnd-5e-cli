class Weapon < Equipment
    
    
    def fill_attributes(data)
        @equipment_category = data["equipment_category"]
        @weapon_category = data["weapon_category"]
        @weapon_range = data["weapon_range"]
        @category_range = data["category_range"]

        @damage_dice = data["damage"]["damage_dice"]
        @damage_bonus = data["damage"]["damage_bonus"]
        @damage_type = data["damage"]["damage_type"]["name"]

        if data.key?("2h_damage")
            @two_handed_weapon = true
            @twoh_damage_dice = data["2h_damage"]["damage_dice"]
            @twoh_damage_bonus = data["2h_damage"]["damage_bonus"]
            @twoh_damage_type = data["2h_damage"]["damage_type"]["name"]
        else
            @two_handed_weapon = false
        end

        @range_normal = data["range"]["normal"]
        @range_long = data["range"]["long"]

        @properties = []
        data["properties"].each {|property| @properties << property["name"]}
        @cost = "#{data["cost"]["quantity"]} #{data["cost"]["unit"]}"
        @weight = data["weight"]

    end

    def print
        puts "\n#{@name}\n\n"
        puts "Equipment Category: #{@equipment_category}\n\n"
        puts "Weapon Category: #{@weapon_category}\n\n"
        puts "Weapon Range: #{@weapon_range}\n\n"
        puts "Category Range: #{@category_range}\n\n"
        puts "Cost: #{@cost}\n\n"
        puts "Damage"
        puts " Damage Dice: #{@damage_dice}"
        puts " Damage Bonus: #{@damage_bonus}"
        puts " Damage Type: #{@damage_type}\n\n"
        puts "Range"
        puts " Normal: #{@range_normal}"
        puts " Long: #{@range_long}\n\n"
        puts "Weight: #{@weight}\n\n"
        puts "Properties:"
        @properties.each {|property| puts property}
        if @two_handed_weapon == true
            puts "\nTwo-handed Damage"
            puts " Damage Dice: #{@twoh_damage_dice}"
            puts " Damage Bonus: #{@twoh_damage_bonus}"
            puts " Damage Type: #{@twoh_damage_type}"
        end
    end
end