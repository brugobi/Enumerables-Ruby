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

  def my_count(arg = nil)
    counter = 0

    if !arg.nil?
      my_each { |i| counter += 1 if i == arg }
    elsif block_given?
      my_each { |i| counter += 1 if yield(i) }
    else
      counter
    end
    counter
  end

  def my_map(a = nil)
    return to_enum unless block_given?

    map_array = []

    if a.nil?
      my_each { |n| map_array << yield(n) }
    else
      my_each { |n| map_array << proc.call(n) }
    end

    map_array
  end

  def my_inject(*args) # rubocop:disable Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity
    args_size = args.length
    result = args[0].is_a?(Integer) ? args[0] : nil
    my_symbol = args[0].is_a?(Symbol) ? args[0] : (args_size > 1 ? args[1] : nil)

    if !my_symbol.nil?

      my_each { |i| result = result ? result.send(my_symbol, i) : i }
    else
      my_each { |i| result = result ? yield(result, i) : i }

    end

    result
  end

  # rubocop:enable
end
