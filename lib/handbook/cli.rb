class Cli

    def initialize
        @alphabet = Array.new(26, " ")
        @alphabet.each_with_index do |block, index|
            if index == 0
                @alphabet[index] = "a"
            else
                @alphabet[index] = @alphabet[index - 1].next
            end
        end
        @ask = "Please enter a number from the following menu or enter 0 to exit: "
    end
    
    def run
        puts "Welcome to the World of Dungeons & Dragons!"
        puts @ask
        main_menu
        selection = gets.to_i
        until selection == 0
            if selection == 1
                handbook_main_menu
            elsif selection == 2
                about
            else
                puts "That is not a correct selection. Please select a number from the following menu: "
                handbook_main_menu
            end
            puts @ask
            main_menu
            selection = gets.to_i
        end
    end

    def main_menu
        puts "\n 1. Handbook"
        puts " 2. About"
        puts " 0. Exit"
    end

    def handbook_main_menu
        puts @ask
        puts "\n 1. Classes"
        puts " 2. Races"
        puts " 3. Equipment"
        puts " 4. Spells"
        puts ""
        handbook_selection
    end

    def handbook_selection
        selection = gets.to_i
        if selection >= 1 && selection <=4
            puts @ask
            if selection == 1 || selection == 2
                list(selection)
            else
                search_or_list_menu(selection)
            end            
        elsif selection == 0
            return
        else
            puts "That is not a correct selection. Please enter a number from the following menu: "
            handbook_main_menu
        end
    end

    def list(selection)
        if selection == 1
            data = Api.load(PlayerClass.endpoint)
            data["results"].each {|block| PlayerClass.find_or_create_by_name(block["name"], block["url"])}
            PlayerClass.all.each_with_index {|player_class, index| puts " #{index + 1}. #{player_class.name}"}
            chosen_class = gets.to_i
            selected = PlayerClass.all.fetch(chosen_class - 1)
            fill_data = Api.load_attributes(selected.attributes_url)
            selected.fill_attributes(fill_data)
            selected.print
        else
            data = Api.load(Race.endpoint)
            data["results"].each {|block| Race.find_or_create_by_name(block["name"], block["url"])}
            Race.all.each_with_index {|race, index| puts " #{index + 1}. #{race.name}"}
            chosen_class = gets.to_i
            selected = Race.all.fetch(chosen_class - 1)
            fill_data = Api.load_attributes(selected.url)
            selected.fill_attributes(fill_data)
            selected.print
        end

    end

    def search_or_list_menu(choice)
        puts "\n 1. Browse by Alphabetized List"
        puts " 2. Search by Name"
        selection = gets.to_i
        if selection == 1
            puts @ask
            alphabetized_list(choice)
        elsif selection == 2
            search(choice)
        else
            puts "That is not a correct selection. Please enter a number from the following menu: "
            search_or_list_menu(choice)
        end 
    end

    def alphabetized_list(selection)
        puts @ask
        @alphabet.each_with_index {|b, i| puts " #{i + 1}. #{b}"} 
        puts " "
        input = gets.to_i
        if selection == 3
            data = Api.load("#{Equipment.endpoint}")
        else selection == 4
            data = Api.load("#{Spell.endpoint}")
        end

        selected = data["results"].select {|info| info["index"][0] == @alphabet[input - 1]}
        selected.each_with_index {|d, index| puts "#{index + 1}. #{d["name"]}"}
        puts @ask
        index = gets.to_i
            if selected[index - 1] != nil
                if selection == 3
                    Equipment.find_or_create_by_name(selected[index - 1]["name"], selected[index - 1]["url"]).print
                else selection == 4
                    Spell.find_or_create_by_name(selected[index - 1]["name"], selected[index - 1]["url"]).fill_attributes.print
                end
            end
    end

    

    def search(selection)
        puts "Please enter the search term: "
        name = gets.strip
        if selection == 3
            data = Api.load("#{Equipment.endpoint}?name=#{name}")
            if data != nil
                Equipment.find_or_create_by_name(data["results"][0]["name"], data["results"][0]["url"]).print
            end
        else
            data = Api.load("#{Spell.endpoint}?name=#{name}")
            if data != nil
                Spell.find_or_create_by_name(data["results"][0]["name"], data["results"][0]["url"]).print
            end
        end
    end
end