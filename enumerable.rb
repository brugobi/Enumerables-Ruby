module Enumerable
  def my_each
    return to_enum unless block_given?
    self.size.times { |n| yield (self[n]) }
  end

  def my_each_with_index
    return to_enum unless block_given?
    self.size.times { |n| yield self[n], n }
  end

  def my_select
    return to_enum unless block_given?
    result_array = []
    self.my_each { |n| result_array << n if yield(n) }
    result_array
  end

end


arr = [1, 2, 3, 4, 5, 6]

# arr.my_each_with_index { |n, i| puts "this is my #{n} and this is my index #{i}" }

puts arr.my_select{|n| n.even?}