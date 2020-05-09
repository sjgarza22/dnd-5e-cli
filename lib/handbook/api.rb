class Api
    BASE_URL = "http://www.dnd5eapi.co/api/"


    # load method will use base url and provided endpoint to GET data
    def self.load(endpoint)
        response = Net::HTTP.get(URI("#{BASE_URL}#{endpoint}")) # this is how we'll grab our data
        data = json_to_array(response)  # converts the JSON to a Ruby friendly array
    end

    # Will convert Json data to readable Ruby array
    def json_to_array(data)
        JSON.parse(data)
    end

    def self.search(endpoint, quiery)
        response = Net::HTTP.get(URI("#{BASE_URL}#{endpoint}=#{quiery}")) # this is how we'll grab our data
        data = json_to_array(response)  # converts the JSON to a Ruby friendly array
    end
end