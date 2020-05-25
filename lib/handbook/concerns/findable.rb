module Findable
    def find_by_name(name)
        all.find {|object| object.name == name}
    end

    def find_or_create_by_name(name, url)
        if !(find_by_name(name))
            create(name, url)
        else
            find_by_name(name)
        end
    end
end