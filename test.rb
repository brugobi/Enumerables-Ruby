def multiply_els (arr)
    arr.my_inject { |sum, n| sum * n }    
end

arr = [2,4,5]

puts multiply_els (arr)