require_relative "kmeans"

class Album < DataPoint
    def initialize(name, year, length, tracks)
        super([length,tracks])
        @name = name
        @year = year
        @length = length
        @tracks = tracks
    end

    def to_s
        "#{@name}, #{@year}"
    end
end

albums = [
    Album.new("Got to Be There", 1972, 35.45, 10),
    Album.new("Ben", 1972, 31.31, 10),
    Album.new("Music & Me", 1973, 32.09, 10),
    Album.new("Forever, Michael", 1975, 33.36, 10),
    Album.new("Off the Wall", 1979, 42.28, 10),
    Album.new("Thriller", 1982, 42.19, 9),
    Album.new("Bad", 1987, 48.16, 10),
    Album.new("Dangerous", 1991, 77.03, 14),
    Album.new("HIStory: Past,Present and Future, Book I", 1995, 148.58, 30),
    Album.new("Invincible", 2001, 77.05, 16)
]

kmeans = KMeans.new(albums, 3)
clusters = kmeans.run
clusters.each_with_index do |cluster, index|
    puts "Cluster #{index}: Avg length #{cluster.centroid.dimensions[0]} Avg tracks #{cluster.centroid.dimensions[1]} #{cluster.points}\n"
end