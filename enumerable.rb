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
    # todo return here when refactoring return to_enum unless block_given?
    self.my_each { |n| return false unless yield(n) }
    true
  end

  def my_any
    # todo return here when refactoring return to_enum unless block_given?
    self.my_each { |n| return true if yield(n) }
    false
  end

  def my_none
    # todo return here and figure it out
    self.my_each { |i| return false if yield(i) == true }
    true
  end

end


arr = [1,3,5]

# arr.my_each_with_index { |n, i| puts "this is my #{n} and this is my index #{i}" }

puts arr.my_none{|n| n.even?}