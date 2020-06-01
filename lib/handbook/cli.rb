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
        @ask = "\nPlease enter a number from the following menu or enter 0 to exit: "
        @incorrect = "\nThat is not a correct selection. Please select a number from the following menu: "
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
        puts " 0. Exit\n\n"
    end

    def handbook_main_menu
        puts @ask
        puts "\n 1. Classes"
        puts " 2. Races"
        puts " 3. Equipment"
        puts " 4. Spells\n\n"
        handbook_selection
    end

    def handbook_selection
        selection = gets.to_i
        if selection >= 1 && selection <=4
            puts "#{@ask}\n\n"
            if selection == 1 || selection == 2
                list(selection)
            else
                search_or_list_menu(selection)
            end            
        elsif selection == 0
            exit
        else
            puts @incorrect
            handbook_main_menu
        end
    end

    def list(selection)
        if selection == 1
            option = PlayerClass 
        else
            option = Race
        end
            data = Api.load(option.endpoint)
            data["results"].each {|block| option.find_or_create_by_name(block["name"], block["url"])}
            option.all.each_with_index {|item, index| puts " #{index + 1}. #{item.name}"}
            index = gets.to_i
            selected = option.all.fetch(index - 1)
            fill_data = Api.load_attributes(selected.url)
            selected.fill_attributes(fill_data)
            selected.print
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
        elsif selection == 0
            exit
        else
            puts @incorrect
            search_or_list_menu(choice)
        end 
    end

    def alphabetized_list(selection)
        puts @ask
        @alphabet.each_with_index {|b, i| puts " #{i + 1}. #{b}"} 
        puts " "
        input = gets.to_i
        if selection == 3
            option = Equipment
        elsif selection == 4
            option = Spell
        elsif selection == 0
            exit
        end

        data = Api.load("#{option.endpoint}")
        selected = data["results"].select {|info| info["index"][0] == @alphabet[input - 1]}
        selected.each_with_index {|d, index| puts "#{index + 1}. #{d["name"]}"}
        puts @ask
        index = gets.to_i
            if selected[index - 1] != nil
                if selection == 3
                    Equipment.find_or_create_by_name(selected[index - 1]["name"], selected[index - 1]["url"]).print
                else selection == 4
                    spell = Spell.find_or_create_by_name(selected[index - 1]["name"], selected[index - 1]["url"])
                    data = Api.load_attributes(spell.url)
                    spell.fill_attributes(data)
                    spell.print 
                end
            end
    end

    

    def search(selection)
        puts "Please enter the search term: "
        name = gets.strip
        if selection == 3
            option = Equipment
            # data = Api.load("#{Equipment.endpoint}?name=#{name}")
            # if data != nil
            #     Equipment.find_or_create_by_name(data["results"][0]["name"], data["results"][0]["url"]).print
            # end
        else
            option = Spell
            
        end
        data = Api.load("#{option.endpoint}?name=#{name}")
            if data != nil
                option.find_or_create_by_name(data["results"][0]["name"], data["results"][0]["url"]).print
            end
    end
end