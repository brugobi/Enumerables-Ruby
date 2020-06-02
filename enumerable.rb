module Enumerable
  def my_each
    return to_enum unless block_given?

    size.times { |n| yield (self[n]) }
  end

  def my_each_with_index
    return to_enum unless block_given?

    size.times { |n| yield self[n], n }
  end

  def my_select
    return to_enum unless block_given?

    result_array = []
    my_each { |n| result_array << n if yield(n) }
    result_array
  end

  def my_all
    return true unless block_given?

    my_each { |n| return false unless yield(n) }
    true
  end

  def my_any
    return true unless block_given?

    my_each { |n| return true if yield(n) }
    false
  end

  def my_none
    return true unless block_given?

    my_each { |i| return false if yield(i) == true }
    true
  end

  def my_count
    counter = 0
    my_each { |i| counter += 1 if yield(i) }
    counter
  end

  def my_map
    return to_enum unless block_given?

    map_array = []
    my_each { |n| map_array << yield(n) }
    map_array
  end
end

arr = [1, 1, 45, 23, 56]

# arr.my_each_with_index { |n, i| puts "this is my #{n} and this is my index #{i}" }

puts arr.my_map(&:even?)
