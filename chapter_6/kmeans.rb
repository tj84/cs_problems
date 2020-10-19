require_relative 'data_point'


class KMeans
    class Cluster
        attr_accessor :points
        attr_accessor :centroid
        def initialize(points, centroid)
            @points = points
            @centroid = centroid
        end
    end

    def initialize(points, k)
        if k < 1
            raise "K must be >= 1"
        end
        @k = k
        @points = points
        zscore_normalize()
        #initalize empty clusters with random centroids
        @clusters = []
        @k.times do 
            random_point = random_point()
            cluster = Cluster.new([], random_point)
            @clusters << cluster
        end
    end

    def centroids
        centroids = []
        @clusters.each do |x|
            centroids << x.centroid
        end
        centroids
    end

    def dimensions_slice(dimension)
        slice = []
        @points.each do |point|
            slice << point.dimensions[dimension]
        end
        slice
    end

    def zscore_normalize
        zscored = []
        @points.size.times do
            zscored << []
        end
        @points[0].num_dimensions.times do |dim|
            dimension_slice = dimensions_slice(dim)
            zscores = zscores(dimension_slice)
            dimension_slice.size.times do |index|
                zscored[index] << zscores[index]
            end
        end
        @points.size.times do |i|
            @points[i].dimensions = zscored[i]
        end
    end

    def random_point
        rand_dimensions = []
        @points[0].num_dimensions.times do |dimension|
            values = dimensions_slice(dimension)
            rng = Random.new
            rand_value = rng.rand(values.min..values.max)
            rand_dimensions.append(rand_value)
        end
        DataPoint.new(rand_dimensions)
    end

    def assign_cluster
        @points.each do |point|
            distance_to_centroids = {}
            @clusters.each do |cluster|
                distance = point.distance(cluster.centroid)
                distance_to_centroids[cluster] = distance
            end
            shortest_distance = distance_to_centroids.values.min
            closest = distance_to_centroids.key(shortest_distance)
            index = centroids.index(closest.centroid)
            cluster = @clusters[index]
            cluster.points.append(point)
        end
    end

    def generate_centroids
        @clusters.each do |cluster|
            if cluster.points.size == 0
                next
            end
            means = []
            cluster.points[0].num_dimensions.times do |dimension|
                slice = []
                cluster.points.each do |point|
                    slice << point.dimensions[dimension]
                end
                means << mean(slice)
            end
            cluster.centroid = DataPoint.new(means)
        end
    end

    def run(iterations = 100)
        iterations.times do |i|
            @clusters.each do |cluster|
                cluster.points = []
            end
            assign_cluster()
            old_centroids = centroids
            old_centroids = old_centroids.clone
            generate_centroids()
            if old_centroids == centroids
                puts "Converged after (#{i}) iterations."
                return @clusters
            end
            @clusters
        end
    end

    private

    def mean(list)
        list.inject(0.0) {|sum, el| sum + el } / list.size
    end
    
    def pstdev(list, mean)
        variance = []
        list.each do |value|
            variance << (value - mean)**2
        end
        sum_variance = variance.inject(0.0) {|sum, el| sum + el}
        Math.sqrt( sum_variance / list.size.to_f)
    end
    
    def zscores(original)
        average = mean(original)
        std = pstdev(original, average)
        if std == 0
            return Array.new(original.size, 0)
        end
        zscores = []
        original.each do |x|
            zscores << ((x - average) / std)
        end
        zscores
    end
end


#point_1 = DataPoint.new([2.0, 1.0, 1.0])
#point_2 = DataPoint.new([2.0, 2.0, 5.0])
#point_3 = DataPoint.new([3.0, 1.5, 2.5])
#kmeans_test = KMeans.new([point_1, point_2, point_3], 2)
#test_clusters = kmeans_test.run
#test_clusters.each_with_index do |cluster, index|
#    puts "Cluster #{index}: #{cluster.points}"
#end