class Cli

    def run
        puts "Welcome to the World of Dungeons & Dragons!"
        puts "Please select a number from the following menu: "
        main_menu
        selection = gets.to_i
        until selection == 0
            puts "Please select a number from the following menu: "
            main_menu
            selection = gets.strip.to_i
            if !(selection >= 0 && selection <=2)
                puts "That is not a correct selection."
            end
        end
    end

    def main_menu
        puts " 1. Handbook"
        puts " 2. About"
        puts " 0. Exit"
    end
end