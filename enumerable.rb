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

  def my_all
    result_array = []
    i = 0
    while i < self.length do
        if yield self [i]
            result_array << self[i]
        end
        i +=1    
    end

    if self.length == result_array.length
        return true
    else
        false
    end        
  end  

end


arr = [4, 2, 6, 7, 8, 6]

# arr.my_each_with_index { |n, i| puts "this is my #{n} and this is my index #{i}" }

puts arr.my_all{|n| n.even?}