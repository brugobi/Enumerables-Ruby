module Enumerable
  def my_each
    return to_enum unless block_given?
    self.size.times { |n| yield (self[n]) }
  end
end


arr = [1, 2, 3, 4, 5, 6]

arr.my_each { |n| puts n * 2 }
