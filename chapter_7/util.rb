def dot_product(list_a, list_b)
    list = []
    list_a.zip(list_b).each do |x, y|
      list << (x * y)
    end
    list.sum
end

def sigmoid(x)
    1.0 / (1.0 + Math.exp(-x))
end

def derivative_sigmoid(x)
    sig = sigmoid(x)
    sig * (1 - sig)
end

def normalize_by_feature_scaling(dataset)
  dataset[0].length.times do |col_num|
    column = []
    dataset.each do |row|
      column << row[col_num]
    end
    maximum = column.max
    minimum = column.min
    dataset.length.times do |row_num|
      dataset[row_num][col_num] = (dataset[row_num][col_num] - minimum) / (maximum - minimum)
    end
  end
end
