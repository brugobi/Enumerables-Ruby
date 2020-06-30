module Enumerable
  def my_each
    return to_enum(:my_each) unless block_given?

    if block_given?
      my_array = is_a?(Range) ? to_a : self
      my_array.size.times { |n| yield (my_array[n]) }
    end
    self
  end

  def my_each_with_index
    return to_enum unless block_given?

    my_array = is_a?(Range) ? to_a : self

    my_array.size.times { |n| yield my_array[n], n }
    self
  end

  def my_select
    return to_enum unless block_given?

    result_array = []
    my_each { |n| result_array << n if yield(n) }
    result_array
  end

  # rubocop:disable Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity
  def my_all?(arg = nil)
    result = true

    my_each do |i|
      result = if arg
                 arg.is_a?(Class) ? i.is_a?(arg) : i.match?(arg)
               elsif block_given?
                 yield i
               else
                 i == false || i.nil? ? false : true
               end
      return false unless result
    end

    result
  end

  def my_any?(arg = nil)
    result = false

    my_each do |i|
      result = if arg
                 arg.is_a?(Class) ? i.is_a?(arg) : i.match?(arg)
               elsif block_given?
                 yield i
               else
                 i == false || i.nil? ? false : true
               end
      return true if result
    end

    result
  end

  def my_none?(arg = nil)
    result = true
    my_each do |i|
      result = if arg
                 arg.is_a?(Class) ? !i.is_a?(arg) : !i.match?(arg)
               elsif block_given?
                 !yield i
               else
                 i == false || i.nil? ? true : false
               end
      break unless result
    end
    result
  end

  def my_count(arg = nil)
    counter = 0

    if !arg.nil?
      my_each { |i| counter += 1 if i == arg }
    elsif block_given?
      my_each { |i| counter += 1 if yield(i) }
    else
      counter = size
    end
    counter
  end

  def my_map(a_proc = nil)
    return to_enum unless block_given?

    map_array = []

    if (block_given? && !a_proc.nil?) || !a_proc.nil?
      my_each { |n| map_array << a_proc.call(n) }
    else
      my_each { |n| map_array << yield(n) }
    end

    map_array
  end

  def my_inject(*args)
    args_size = args.length
    result = args[0].is_a?(Integer) ? args[0] : nil
    my_symbol = args[0].is_a?(Symbol) ? args[0] : nil
    my_symbol = args[1] if my_symbol.nil? and args_size > 1

    if !my_symbol.nil?

      my_each { |i| result = result ? result.send(my_symbol, i) : i }
    else
      my_each { |i| result = result ? yield(result, i) : i }

    end

    result
  end

  # rubocop:enable Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity
end

def multiply_els(arr)
  arr.my_inject { |sum, n| sum * n }
end

# arr = [1, 2, 7, 4, 5]

# puts multiply_els(arr)

# my_proc = proc { |x| x * 2 }
# p arr.my_map(my_proc) { |x| x * 1 }

# puts '################# my_all'
# puts %w[ant bear cat].my_all? { |word| word.length >= 3 } #=> true
# puts %w[ant bear cat].my_all? { |word| word.length >= 4 } #=> false
# puts %w[ant bear cat].my_all?(/t/) #=> false
# puts [1, 2i, 3.14].my_all?(Numeric) #=> true
# puts [nil, true, 99].my_all? #=> false
# puts [].my_all? #=> true
# puts

# puts '################# my_any'
# puts %w[ant bear cat].my_any? { |word| word.length >= 3 } #=> true
# puts %w[ant bear cat].my_any? { |word| word.length >= 4 } #=> true
# puts %w[ant bear cat].my_any?(/d/) #=> false
# puts [nil, true, 99].my_any?(Integer) #=> true
# puts [nil, true, 99].my_any? #=> true
# puts [].my_any? #=> false
# puts

# puts '################# my_none?'
# puts %w[ant bear cat].my_none? { |word| word.length == 5 } #=> true
# puts %w[ant bear cat].my_none? { |word| word.length >= 4 } #=> false
# puts %w[ant bear cat].my_none?(/d/) #=> true
# puts [1, 3.14, 42].my_none?(Float) #=> false
# puts [].my_none? #=> true
# puts [nil].my_none? #=> true
# puts [nil, false].my_none? #=> true
# puts [nil, false, true].my_none? #=> false
