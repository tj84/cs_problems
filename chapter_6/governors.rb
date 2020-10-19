require_relative "kmeans"

class Governor < DataPoint
    def initialize(longitude, age, state)
        super([longitude, age])
        @longitude = longitude
        @age = age
        @state = state
    end

    def to_s
        "#{@state}: longitude: #{@longitude}, age: #{@age}"
    end
end

governors = [
    Governor.new(-86.79113, 72, "Alabama"), 
    Governor.new(-152.404419, 66, "Alaska"),
    Governor.new(-111.431221, 53, "Arizona"), 
    Governor.new(-92.373123, 66, "Arkansas"),
    Governor.new(-119.681564, 79, "California"), 
    Governor.new(-105.311104, 65, "Colorado"),
    Governor.new(-72.755371, 61, "Connecticut"),
    Governor.new(-75.507141, 61, "Delaware"),
    Governor.new(-81.686783, 64, "Florida"), 
    Governor.new(-83.643074, 74, "Georgia"),
    Governor.new(-157.498337, 60, "Hawaii"), 
    Governor.new(-114.478828, 75, "Idaho"),
    Governor.new(-88.986137, 60, "Illinois"), 
    Governor.new(-86.258278, 49, "Indiana"),
    Governor.new(-93.210526, 57, "Iowa"),
    Governor.new(-96.726486, 60, "Kansas"),
    Governor.new(-84.670067, 50, "Kentucky"),
    Governor.new(-91.867805, 50, "Louisiana"),
    Governor.new(-69.381927, 68, "Maine"), 
    Governor.new(-76.802101, 61, "Maryland"),
    Governor.new(-71.530106, 60, "Massachusetts"), 
    Governor.new(-84.536095, 58, "Michigan"),
    Governor.new(-93.900192, 70, "Minnesota"), 
    Governor.new(-89.678696, 62, "Mississippi"),
    Governor.new(-92.288368, 43, "Missouri"),
    Governor.new(-110.454353, 51, "Montana"),
    Governor.new(-98.268082, 52, "Nebraska"), 
    Governor.new(-117.055374, 53, "Nevada"),
    Governor.new(-71.563896, 42, "New Hampshire"), 
    Governor.new(-74.521011, 54, "New Jersey"),
    Governor.new(-106.248482, 57, "New Mexico"), 
    Governor.new(-74.948051, 59, "New York"),
    Governor.new(-79.806419, 60, "North Carolina"), 
    Governor.new(-99.784012, 60, "North Dakota"),
    Governor.new(-82.764915, 65, "Ohio"), 
    Governor.new(-96.928917, 62, "Oklahoma"),
    Governor.new(-122.070938, 56, "Oregon"), 
    Governor.new(-77.209755, 68, "Pennsylvania"),
    Governor.new(-71.51178, 46, "Rhode Island"), 
    Governor.new(-80.945007, 70, "South Carolina"),
    Governor.new(-99.438828, 64, "South Dakota"), 
    Governor.new(-86.692345, 58, "Tennessee"),
    Governor.new(-97.563461, 59, "Texas"), 
    Governor.new(-111.862434, 70, "Utah"),
    Governor.new(-72.710686, 58, "Vermont"), 
    Governor.new(-78.169968, 60, "Virginia"),
    Governor.new(-121.490494, 66, "Washington"), 
    Governor.new(-80.954453, 66, "West Virginia"),
    Governor.new(-89.616508, 49, "Wisconsin"), 
    Governor.new(-107.30249, 55, "Wyoming")
]

kmeans = KMeans.new(governors, 2)
gov_cluster = kmeans.run
gov_cluster.each_with_index do |cluster, index|
    puts "Cluster #{index}: #{cluster.points}"
end