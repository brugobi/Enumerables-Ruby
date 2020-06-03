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

  # def my_map
  #   return to_enum unless block_given?

  #   map_array = []
  #   my_each { |n| map_array << yield(n) }
  #   map_array
  # end

  def my_map(my_proc = nil)
    return to_enum unless block_given?

    map_array = []

    if my_proc.nil?
      my_each { |n| map_array << my_proc.call(n) }
    else
      my_each { |n| map_array << yield(n) }
    end

    map_array
  end

  def my_inject(*args) # rubocop:disable Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity
    args_size = args.length
    result = args[0].is_a?(Integer) ? args[0] : nil

    if args_size.zero? # nor arguments so block was called, we use yield

      my_each { |i| result = result ? yield(result, i) : i }

      return result
    end

    if args[0].is_a?(Symbol) # symbol only

      my_each { |i| result = result ? result.send(args[0], i) : i }
      return result
    end

    if args_size > 1 # it has both the initial and the Symbol

      my_each { |i| result = result.send(args[1], i) }
      return result
    end

    return unless args[0].is_a?(Integer)

    my_each { |i| result = yield(result, i) }
    result
  end

  # rubocop:enable
end

arr = [5, 6, 7, 8, 9, 10]

# puts arr.my_map

puts arr.my_inject(:+)
puts arr.my_inject { |sum, n| sum + n }
puts arr.my_inject(1, :*)
puts arr.my_inject(1) { |product, n| product * n }

longest = %w[cat sheep bear].inject do |memo, word|
  memo.length > word.length ? memo : word
end

puts longest

# def multiply_els(arr)
#   p arr.my_inject(1) { |r, i| r * i }
# end

# multiply_els(arr)
