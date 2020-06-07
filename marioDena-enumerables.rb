# This is the original code from @MarioDena all work here belongs to him, blah blah blah
# The purpose of this is to call his my_map with both a proc and block and see if ruby runs it
# rubocop disable Metrics/MethodLength

module Enumerable
  def my_each
    return to_enum(:my_each) unless block_given?

    i = 0
    ar = to_a
    while i < size
      yield(ar[i])
      i += 1
    end
  end

  def my_each_with_index
    return to_enum if block_given? == false

    i = 0
    ar = to_a
    while i < ar.size
      yield(ar[i], i)
      i += 1
    end
  end

  def my_select
    return to_enum if block_given? == false

    i = 0
    ar = to_a
    array = []
    while i < ar.size
      array << ar[i] if yield(ar[i])
      i += 1
    end
    array
  end

  def my_all?(args = nil)
    i = 0
    ar = to_a

    while i < ar.size
      if block_given? == true
        return false unless yield(ar[i])
      elsif args.class == Class
        return false unless ar[i].class.ancestors.include? args
      elsif args.class == Regexp
        return false unless ar[i] =~ args
      elsif args.nil? == true
        return false unless ar[i]
      else
        return false unless args[i] == ar[i]
      end
      i += 1
    end
    true
  end

  def my_any?(args = nil)
    i = 0
    ar = to_a
    while i < ar.size
      if block_given? == true
        return true if yield(ar[i])
      elsif args.class == Class
        return true if ar[i].class.ancestors.include? args
      elsif args.class == Regexp
        return true if ar[i] =~ args
      elsif args.nil? == true
        return true if ar[i]
      elsif args == ar[i]
        return true
      end

      i += 1
    end
    false
  end

  def my_none?(args = nil)
    i = 0
    ar = to_a
    while i < ar.size
      if block_given? == true
        return false if yield (ar[i])
      elsif args.class == Class
        return false if ar[i].class.ancestors.include? args
      elsif args.class == Regexp
        return false if ar[i] =~ args
      elsif args.nil? == true
        return false if ar[i]
      elsif args[i] == ar[i]
        return false
      end

      i += 1
    end
    true
  end

  def my_count(args = '')
    ar = to_a
    i = 0
    count = 0
    if block_given? == false
      while i < ar.size
        if args != ''
          count += 1 if ar[i] == args
        else
          count += 1
        end
        i += 1
      end
    else
      while i < ar.size
        count += 1 if yield(ar[i])
        i += 1
      end
    end
    count
  end

  def my_map(&proc)
    return to_enum if block_given? == false

    i = 0
    ar = to_a
    array = []
    while i < ar.size
      array << if block_given?
                 yield(ar[i])
               else
                 proc.call(ar[i])
               end
      i += 1
    end
    array
  end

  def my_inject(*args)
    i = 0
    ar = to_a
    injector_result = 0
    if args[1].nil? && !block_given?
      symbol = args[0]
    elsif args[1].nil? && block_given?
      injector_result = args[0]
    else
      injector_result = args[0]
      symbol = args[1]
    end
    injector_result = 0 if args.empty?

    while i < ar.size
      injector_result = if symbol
                          injector_result.send(symbol, ar[i])
                        else
                          yield(injector_result, ar[i])
                        end
      i += 1
    end

    injector_result
  end
end

################# Testing Suite ##################
# rubocop enable Metrics/MethodLength
# rubocop:enable Metrics/CyclomaticComplexity
# rubocop:enable Metrics/PerceivedComplexity
# rubocop:enable Metrics/ModuleLength
# rubocop: enable Metrics/BlockNesting

arr = [1, 2, 3, 4]

# puts multiply_els(arr)

my_proc = proc { |n| 2 * n }
puts arr.my_map(&my_proc) { |n| 3 * n }
