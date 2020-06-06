module Enumerable
  def my_each
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
                 arg.is_a?(Class) ? i.is_a?(arg) : i.to_s.match?(arg.to_s)
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
                 arg.is_a?(Class) ? i.is_a?(arg) : i.to_s.match?(arg.to_s)
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
                 arg.is_a?(Class) ? !i.is_a?(arg) : !i.to_s.match?(arg.to_s)
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

    if a_proc.nil?
      my_each { |n| map_array << yield(n) }
    else
      my_each { |n| map_array << proc.call(n) }
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
